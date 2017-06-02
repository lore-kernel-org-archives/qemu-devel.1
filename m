Received: from eggs.gnu.org ([2001:4830:134:3::10]:37642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGphW-0001VK-9s
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGphV-0004te-EG
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:45:26 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGphV-0004sy-88
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:45:25 -0400
Received: by mail-wm0-x229.google.com with SMTP id b84so30010345wmh.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 09:45:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2b22afa9-d3fa-99d3-c53d-696215041ffa@redhat.com>
References: <20170601170733.13080-1-pbonzini@redhat.com>
	<CAFEAcA9Yteb5jsB2AJhuhx1Ejg+nwrF8PgetRWv+yFPduLHOgg@mail.gmail.com>
	<CAFEAcA9zPWDQ8Y6ugAut5WobLXzP3zrUeUUH7RcSUMqdLkkndA@mail.gmail.com>
	<2b22afa9-d3fa-99d3-c53d-696215041ffa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 17:45:03 +0100
Message-ID: <CAFEAcA8BLcP3sdz=+SDk0r6tH4ZoM+87RyfD8w0AnTe8T_gJvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/34] Misc patches for 2016-06-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 09:06, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 01/06/2017 19:56, Peter Maydell wrote:
>> On 1 June 2017 at 18:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Test failure on OSX:
>>>
>>> TEST: tests/device-introspect-test... (pid=66373)
>>>   /aarch64/device/introspect/list:                                     OK
>>>   /aarch64/device/introspect/none:                                     OK
>>>   /aarch64/device/introspect/abstract:                                 OK
>>>   /aarch64/device/introspect/concrete:                                 **
>>> ERROR:/root/qemu/qom/object.c:364:object_initialize_with_type:
>>> assertion failed: (type != NULL)
>>> Broken pipe
>>
>> Got those the wrong way round -- this is the FreeBSD failure
>> and the other lot are OSX. Pretty sure it's the same error,
>> though -- it's just that for some reason my OSX setup doesn't
>> actually cause make to exit with an error when a test fails,
>> so it goes on to hit what's probably the same bug in all the
>> other check-qtest-$ARCH targets rather than bailing out.
>
> Thanks, any chance you can bisect these?  I'll install a FreeBSD VM next
> week.

No bisection, but using QTEST_LOG:

QTEST_LOG=1 QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
255 + 1))} gtester -k --verbose -m=quick tests/device-introspect-test
-p=/aarch64/device/introspect/concrete
[...]
{"return": "/machine (none-machine)\r\n  /peripheral (container)\r\n
/peripheral-anon (container)\r\n  /unattached (container)\r\n
/io[0] (qemu:memory-region)\r\n    /sysbus (System)\r\n    /system[0]
(qemu:memory-region)\r\n"}{"execute": "device-list-properties",
"arguments": {"typename": "vhost-user-scsi-pci"}}

**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
FAIL

suggests that there's a bug in the new vhost-user-scsi-pci
device. Specifically in commit 550811c37e0f2
("vhost-user-scsi: Introduce vhost-user-scsi host device")
hw/virtio/virtio-pci.c is changed to unconditionally call
type_register_static(&vhost_user_scsi_pci_info), whose
instance_init method tries to use TYPE_VHOST_USER_SCSI,
but hw/scsi/vhost-user-scsi.c (where that type is defined)
is only compiled if CONFIG_VHOST_USER_SCSI is set (which
only happens for Linux).

thanks
-- PMM
