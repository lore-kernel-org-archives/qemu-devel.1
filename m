Received: from eggs.gnu.org ([2001:4830:134:3::10]:38165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dICIR-0004xy-TQ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dICIQ-0002hd-Hf
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:05:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
	<b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
Date: Tue, 06 Jun 2017 13:05:05 +0200
In-Reply-To: <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru> (Michael
	Tokarev's message of "Tue, 6 Jun 2017 10:10:06 +0300")
Message-ID: <878tl5wf4u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org, peter.maydell@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org, f4bug@amsat.org

Michael Tokarev <mjt@tls.msk.ru> writes:

> 06.06.2017 09:54, Markus Armbruster wrote:
>
> [ ./configure --disable-linux-user --disable-system --static ]
>
>> I haven't, but here's a quick guess on what we need to squash into the
>> patch:
>> 
>> diff --git a/Makefile b/Makefile
>> index c830d7a..2ef5a78 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -469,10 +469,12 @@ ifneq ($(EXESUF),)
>>  qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
>>  endif
>>  
>> +ifdef CONFIG_IVSHMEM
>>  ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>>  	$(call LINK, $^)
>>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>>  	$(call LINK, $^)
>> +endif
>
> This effectively disables building ivshmem executables on this config
> on linux, while previously they were building fine. Hmm..

These executables are only useful together with an ivshmem device.  Not
building them when they can't be useful makes sense to me.

See previous discussion
Message-ID: <87fufwjfqw.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05108.html
