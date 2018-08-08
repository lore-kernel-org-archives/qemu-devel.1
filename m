Received: from eggs.gnu.org ([2001:4830:134:3::10]:48318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnRr3-0000ll-QQ
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 13:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnRqy-0007vj-RR
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 13:02:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnRqy-0007vX-LE
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 13:02:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CF827A7E8
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 17:02:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <81c76597-7dd3-59f0-8b04-4972e489bbc8@redhat.com> (Thomas Huth's
	message of "Wed, 8 Aug 2018 14:06:37 +0200")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-6-quintela@redhat.com>
	<81c76597-7dd3-59f0-8b04-4972e489bbc8@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 08 Aug 2018 19:02:24 +0200
Message-ID: <87lg9gx04f.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 05/22] check: Only test usb-xhci-nec
 when it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 08/08/2018 01:48 PM, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/Makefile.include | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 4e5f47aac0..1105469daa 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -290,8 +290,9 @@ endif
>>  gcov-files-i386-$(CONFIG_USB_EHCI) += hw/usb/hcd-ehci.c
>>  gcov-files-i386-y += hw/usb/dev-hid.c
>>  gcov-files-i386-y += hw/usb/dev-storage.c
>> -check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
>> -gcov-files-i386-y += hw/usb/hcd-xhci.c
>> +check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
>> +gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
>> +gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci-nec.c
>
> Maybe use CONFIG_USB_XHCI_NEC for the hcd-xhci-nec.c entry instead?

Not sure, this split looks artifitial. My read of this:


commit 0bbb2f3df1ffd9ccf7135a69a450c6929bc0b915
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Wed May 17 12:33:12 2017 +0200

    xhci: split into multiple files
    

Is that it got split so we could add more controllers that never
happened.  I am not sure what we need to do.

>>  check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
>>  check-qtest-i386-y += tests/q35-test$(EXESUF)
>>  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
>> @@ -349,8 +350,8 @@ check-qtest-ppc64-$(CONFIG_USB_OHCI) +=
>> tests/usb-hcd-ohci-test$(EXESUF)
>>  gcov-files-ppc64-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
>>  check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
>>  gcov-files-ppc64-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
>> -check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
>> -gcov-files-ppc64-y += hw/usb/hcd-xhci.c
>> +check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
>> +gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
>
> Also add hcd-xhci-nec.c gcov entry here?

I didn't want to go "further", but I think that we should have here is
something like:


check-qtest-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
gcov-files-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c

and remove the arch specific bits.  If one arch don't support it, we
know have CONFIG_USB_XHCI bits to not _enable_ it there.

What do you think?

Thanks, Juan.
