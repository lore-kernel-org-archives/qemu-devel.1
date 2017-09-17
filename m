Received: from eggs.gnu.org ([2001:4830:134:3::10]:51800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1dtNGS-0007VN-Ra
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1dtNGN-0005CK-EM
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:16:48 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.dakinevich@gmail.com>)
	id 1dtNGN-00059C-1t
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:16:43 -0400
Received: by mail-lf0-x242.google.com with SMTP id y15so2874195lfd.0
	for <qemu-devel@nongnu.org>; Sat, 16 Sep 2017 17:16:41 -0700 (PDT)
References: <1505406696-2260-1-git-send-email-jan.dakinevich@gmail.com>
	<20170915165624.1e9b51c2@bahia.lan>
From: Jan Dakinevich <jan.dakinevich@gmail.com>
Message-ID: <71aa093a-d640-b67f-0e70-144d0a451f44@gmail.com>
Date: Sun, 17 Sep 2017 03:19:01 +0300
MIME-Version: 1.0
In-Reply-To: <20170915165624.1e9b51c2@bahia.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: check the size of transport buffer
 before marshaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Greg,

> I couldn't find a way to break transport
> with 9p2000.L. Do you have a reproducer for the latter ?

You're right! The problem is related only to 9p2000.u protocol. In this 
protocol to list a directory folowing chain is used: TOPEN->TREAD. 
9p2000.L uses for the same goal TLOPEN->TREADDIR.

As I just figured out TREADDIR never fails in marshaling stage because 
it calls v9fs_do_readdir which checks for availble buffer size 
(max_count) before marshaling.

I am preparing new patch being inspired by v9fs_do_readdir()'s behavior.

On 09/15/2017 05:56 PM, Greg Kurz wrote:
> On Thu, 14 Sep 2017 19:31:36 +0300
> Jan Dakinevich <jan.dakinevich@gmail.com> wrote:
> 
>> v9fs_do_readdir_with_stat() and v9fs_do_readdir() stores as much data in
>> the buffer as can fit unless marshaling erorr occurs. However, after
>> commit 23a006d the behavior pdu_marshal was changed, and on error the
>> routine assumes that buffers are misconfigured and breaks communication.
>>
> 
> I agree and I could easily reproduce with a linux guest using 9p2000.u, ie, the
> v9fs_do_readdir_with_stat() case, but I couldn't find a way to break transport
> with 9p2000.L. Do you have a reproducer for the latter ?
> 
> I ask because I would appreciate to see some more details in the changelog,
> for the records.
> 
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
>> ---
> 
> Anyway the patch looks fine, but I'll wait for your answer before pushing
> to 9p-next.
> 
> Cheers,
> 
> --
> Greg
> 
>>   hw/9pfs/9p.c | 44 ++++++++++++++++++++++++++++++++------------
>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index 1e38109..8e0b87e 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -1679,6 +1679,16 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
>>       qemu_iovec_concat(qiov, &elem, skip, size);
>>   }
>>   
>> +static size_t v9fs_marshal_size(V9fsPDU *pdu)
>> +{
>> +    struct iovec *iov;
>> +    unsigned int niov;
>> +
>> +    pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, 0);
>> +
>> +    return iov_size(iov, niov);
>> +}
>> +
>>   static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
>>                              uint64_t off, uint32_t max_count)
>>   {
>> @@ -1725,6 +1735,10 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
>>       off_t saved_dir_pos;
>>       struct dirent *dent;
>>   
>> +    /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
>> +    size_t offset = 11;
>> +    size_t marshal_size = v9fs_marshal_size(pdu);
>> +
>>       /* save the directory position */
>>       saved_dir_pos = v9fs_co_telldir(pdu, fidp);
>>       if (saved_dir_pos < 0) {
>> @@ -1752,18 +1766,23 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
>>           if (err < 0) {
>>               break;
>>           }
>> -        /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
>> -        len = pdu_marshal(pdu, 11 + count, "S", &v9stat);
>>   
>> -        v9fs_readdir_unlock(&fidp->fs.dir);
>> +        if (v9stat.size + 2 > MIN(marshal_size - offset, max_count - count)) {
>> +            v9fs_readdir_unlock(&fidp->fs.dir);
>>   
>> -        if ((len != (v9stat.size + 2)) || ((count + len) > max_count)) {
>>               /* Ran out of buffer. Set dir back to old position and return */
>>               v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
>>               v9fs_stat_free(&v9stat);
>>               v9fs_path_free(&path);
>>               return count;
>>           }
>> +
>> +        len = pdu_marshal(pdu, offset, "S", &v9stat);
>> +        BUG_ON(len != v9stat.size + 2);
>> +
>> +        v9fs_readdir_unlock(&fidp->fs.dir);
>> +
>> +        offset += len;
>>           count += len;
>>           v9fs_stat_free(&v9stat);
>>           v9fs_path_free(&path);
>> @@ -1884,6 +1903,10 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>>       off_t saved_dir_pos;
>>       struct dirent *dent;
>>   
>> +    /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
>> +    size_t offset = 11;
>> +    size_t marshal_size = v9fs_marshal_size(pdu);
>> +
>>       /* save the directory position */
>>       saved_dir_pos = v9fs_co_telldir(pdu, fidp);
>>       if (saved_dir_pos < 0) {
>> @@ -1899,7 +1922,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>>           }
>>           v9fs_string_init(&name);
>>           v9fs_string_sprintf(&name, "%s", dent->d_name);
>> -        if ((count + v9fs_readdir_data_size(&name)) > max_count) {
>> +        if (v9fs_readdir_data_size(&name) > MIN(marshal_size - offset,
>> +                                                max_count - count)) {
>>               v9fs_readdir_unlock(&fidp->fs.dir);
>>   
>>               /* Ran out of buffer. Set dir back to old position and return */
>> @@ -1918,18 +1942,14 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>>           qid.type = 0;
>>           qid.version = 0;
>>   
>> -        /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
>> -        len = pdu_marshal(pdu, 11 + count, "Qqbs",
>> +        len = pdu_marshal(pdu, offset, "Qqbs",
>>                             &qid, dent->d_off,
>>                             dent->d_type, &name);
>> +        BUG_ON(len != v9fs_readdir_data_size(&name));
>>   
>>           v9fs_readdir_unlock(&fidp->fs.dir);
>>   
>> -        if (len < 0) {
>> -            v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
>> -            v9fs_string_free(&name);
>> -            return len;
>> -        }
>> +        offset += len;
>>           count += len;
>>           v9fs_string_free(&name);
>>           saved_dir_pos = dent->d_off;
> 

-- 
Best regards,
Jan Dakinevich
