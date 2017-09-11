Received: from eggs.gnu.org ([2001:4830:134:3::10]:41107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drKng-0000dB-1q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drKnb-0006qV-3A
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:14:40 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drKna-0006pm-TB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:14:35 -0400
Received: by mail-wm0-f52.google.com with SMTP id 189so6615694wmh.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 02:14:34 -0700 (PDT)
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-10-pbonzini@redhat.com>
	<20170830163750.GY24565@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49202119-02f9-af09-6a69-5360e747f91f@redhat.com>
Date: Mon, 11 Sep 2017 11:14:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170830163750.GY24565@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/10] scsi: add multipath
 support to qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 30/08/2017 18:37, Stefan Hajnoczi wrote:
> 
> The case statements asssume sz has a certain minimum value.  I didn't
> see a check anywhere that guarantees this.  It may be easier to hide the
> client's sz value and instead use sizeof(client->data).  The caller can
> worry about sz.

Makes sense.  OUT needs the client sz, but IN doesn't and it gets in the
way.  This lets me just assert in multipath_pr_in that sz is large enough.

>> +    /* Convert input data, especially transport IDs, to the structs
>> +     * used by libmpathpersist (which, of course, will immediately
>> +     * do the opposite).
>> +     */
>> +    memset(&paramp, 0, sizeof(paramp));
>> +    memcpy(&paramp.key, &param[0], 8);
>> +    memcpy(&paramp.sa_key, &param[8], 8);
>> +    paramp.sa_flags = param[10];
>> +    for (i = PR_OUT_FIXED_PARAM_SIZE, j = 0; i < sz; ) {
>> +        struct transportid *id = (struct transportid *) &transportids[j];
>> +        int len;
>> +
>> +        id->format_code = param[i] & 0xc0;
>> +        id->protocol_id = param[i] & 0x0f;
>> +        switch (param[i] & 0xcf) {
> At this point we know sz > PR_OUT_FIXED_PARAM_SIZE && i < sz.  I think
> the following case statements can read beyond the end of client->data[]
> because nothing checks sz before accessing param[].
> 
> Missing sz checks?

There is a transport id length field that has to be checked against sz,
indeed.  After doing that, the for loop is fine (though the initial
index is wrong, because PR_OUT_FIXED_PARAM_SIZE points to the length
field and the transport ids are at PR_OUT_FIXED_PARAM_SIZE + 4).

>> +            /* iSCSI transport.  */
>> +            len = lduw_be_p(&param[i + 2]);
>> +            if (len > 252 || (len & 3)) {
> 
> int len can be negative here .  Please use the size_t type - it's
> unsigned and used by memchr(3)/memcpy(3).

Can it? lduw_be_p reads 16 bits (and it's unsigned as the name says).

Paolo
