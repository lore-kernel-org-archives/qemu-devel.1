Received: from eggs.gnu.org ([2001:4830:134:3::10]:35525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjfeP-0005ek-NB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjfeO-0007jJ-Tu
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:21:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-7-git-send-email-armbru@redhat.com>
	<d4d7ef14-2b0b-e8f3-69f3-9a2b9e81bd39@redhat.com>
Date: Fri, 03 Mar 2017 06:21:01 +0100
In-Reply-To: <d4d7ef14-2b0b-e8f3-69f3-9a2b9e81bd39@redhat.com> (Eric Blake's
	message of "Thu, 2 Mar 2017 17:32:20 -0600")
Message-ID: <8760jr7x6q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/15] sheepdog: Don't truncate long VDI
 name in _open(), _create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/02/2017 03:43 PM, Markus Armbruster wrote:
>> sd_parse_uri() truncates long VDI names silently.  Reject them
>> instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/sheepdog.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/block/sheepdog.c b/block/sheepdog.c
>> index deb110e..72a52a6 100644
>> --- a/block/sheepdog.c
>> +++ b/block/sheepdog.c
>> @@ -985,7 +985,9 @@ static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
>>          ret = -EINVAL;
>>          goto out;
>>      }
>> -    pstrcpy(vdi, SD_MAX_VDI_LEN, uri->path + 1);
>> +    if (g_strlcpy(vdi, uri->path + 1, SD_MAX_VDI_LEN) >= SD_MAX_VDI_LEN) {
>> +        goto out;
>> +    }
>
> Does this need to set ret? Maybe to -EINVAL?

Yes.  The next patch heals it, but of course I'll fix it anyway.

>>  
>>      qp = query_params_parse(uri->query);
>>      if (qp->n > 1 || (s->is_unix && !qp->n) || (!s->is_unix && qp->n)) {
>> 
