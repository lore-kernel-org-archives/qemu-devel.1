Received: from eggs.gnu.org ([2001:4830:134:3::10]:56417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezLXn-0004GD-DP
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezLXm-0000a4-D4
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:11:39 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezLXm-0000ZZ-80
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:11:38 -0400
Received: by mail-oi0-x22f.google.com with SMTP id 71-v6so10103357oie.12
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 05:11:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6b4fbb94-2c28-27c2-17e4-b3ce593eb04d@redhat.com>
References: <d29ae6aa-5758-277b-b754-4e6fe7666e6b@redhat.com>
	<CAFEAcA9dHPLj6aF=JsS8dXaDWf_ONQ_A+SD1xXQO7DdsWK3yAw@mail.gmail.com>
	<6b4fbb94-2c28-27c2-17e4-b3ce593eb04d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 12:11:17 +0000
Message-ID: <CAFEAcA_rJ_=-dKauAmrJPGRJ6C09_9CQzRdXK53va4NB_xXKpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Regression on KVM qemu-system-aarch64 since
 "monitor: enable IO thread for (qmp & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu list <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>

On 23 March 2018 at 12:01, Auger Eric <eric.auger@redhat.com> wrote:
> Hi,
>
> On 23/03/18 11:26, Peter Maydell wrote:
>> On 23 March 2018 at 10:24, Auger Eric <eric.auger@redhat.com> wrote:
>>> Hi,
>>>
>>> I observe a regression on KVM accelerated qemu-system-aarch64:
>>>
>>> Unexpected error in kvm_device_access() at
>>> /home/augere/UPSTREAM/qemu/accel/kvm/kvm-all.c:2164:
>>> 2018-03-23T09:59:59.629439Z qemu-system-aarch64: KVM_GET_DEVICE_ATTR
>>> failed: Group 6 attr 0x000000000000c664: Device or resource busy
>>> 2018-03-23 10:00:00.085+0000: shutting down, reason=crashed
>>
>> Can you get a backtrace for this? (I guess you'd need to fiddle
>> with the kvm_device_access() code to make it assert rather
>> than passing back the error).
>
> OK. I will try to do so. As I could have expected, I cannot reproduce on
> a standalone qemu command line. The problem observed above is seen with
> libvirt launch which may be doing some other QMP stuff concurrently?

Hmm, that could be a bit painful to debug. I dunno if libvirt
has a "launch QEMU under gdb" option. If not, you could try
something like:
   if (condition we want to get a backtrace on) {
       printf("hit condition, attach gdb to process %d\n", (int)getpid());
       for (;;) { }
   }

and then QEMU will sit in a loop waiting for you to do a
  gdb path/to/qemu <pid>

thanks
-- PMM
