Received: from eggs.gnu.org ([2001:4830:134:3::10]:49808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dxwr0-0004Io-9v
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 11:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dxwqx-00070f-5k
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 11:05:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dxwqw-0006vJ-Qq
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 11:05:22 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <f2121741-9ecd-ed6e-a009-ba48a977a742@samsung.com>
Date: Fri, 29 Sep 2017 18:05:13 +0300
MIME-version: 1.0
In-reply-to: <20170929104657.GC11930@redhat.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <CGME20170929101124eucas1p25695c76db8f17ef8181ee2b3051bba98@eucas1p2.samsung.com>
	<1506679874-22284-1-git-send-email-a.perevalov@samsung.com>
	<20170929104657.GC11930@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fix tests/migration/stress build
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 01:46 PM, Daniel P. Berrange wrote:
> On Fri, Sep 29, 2017 at 01:11:13PM +0300, Alexey Perevalov wrote:
>> This small commit fixes build of tests/migration/stress on Ubuntu16.04
>> (on RHEL7.4 the same situation, after typical configure with following options
>> --target-list=x86_64-linux-user,i386-linux-user,x86_64-softmmu,i386-softmmu \
>> --enable-numa --enable-kvm --enable-vhost-net --enable-tpm --enable-debug \
>>   --disable-gtk )
>> PTHREAD_LIB is empty after successfully compiled pthread sample in configure.
>> tests/migration/stress relay on it, but -pthread is not there
>> and linker fails trying to resolve pthread symbols.
>>
>> I still have a questions:
>> 1. Is there a better way to obtain -thread option from QEMU_CFLAGS
>> 2. Is linker options really necessary for stress application, because only -O3
>> is used, so w/o linker options in Makefile there is no need in PTHREAD_LIB
>> at all, I mean in whole project.
>> 3. LINKPROG will be expanded into c++ firstly, and -static in
>> tests/Makefile.include will require static libstdc++, but configure doesn't
>> check it and in case of missing libstdc++-static.x86_64 (RHEL package name),
>> build will fail with the following message: "ld: cannot find -lstdc++",
>> I think here reasonably to use just $(CC) instead of LINKPROG, stress.c is on C.
> Yeah, changing to $(CC) is fine - and adding -lpthread to the end of the
> args instead of $PTHREAD_LIB
ok, but I think it's possible to swap CXX and CC in LINKPROG,
like that
-LINKPROG = $(or $(CXX),$(CC))
+LINKPROG = $(or $(CC), $(CXX))
in this case CC will be invoked early,
I think that issue with static library is general for all LINKPROG
usage, lie EXESUF and DSOSUF, isn't it?
>
>> Also ./tests/migration/guestperf.py can not be started w/o
>> super user privileges, and reports in this case something useless like this:
>> Error: [Errno 104] Connection reset by peer
> IIRC, that's an Ubuntu problem - they pointlessly restrict their
> /boot/vmlinuz files so you can't read them as non-root. Use the
> --kernel arg to point to a readable image. There's no need for
> the test to run privileged
>
> Regards,
> Daniel


-- 
Best regards,
Alexey Perevalov
