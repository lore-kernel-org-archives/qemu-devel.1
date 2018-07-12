Received: from eggs.gnu.org ([2001:4830:134:3::10]:55510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdWaw-0003wG-7O
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdWaq-0001kR-Hx
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:04:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdWaq-0001jz-CY
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:04:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so20677941wrd.4
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 01:04:52 -0700 (PDT)
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
	<CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
	<955f26d7-5a0b-28e0-bd0f-f663593afefe@redhat.com>
	<1be41104-d896-b03b-e0f3-47ea9c3b333f@redhat.com>
	<20180711195924.GC7451@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8275fafc-7f3b-616e-5702-7595ed1466be@redhat.com>
Date: Thu, 12 Jul 2018 10:04:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180711195924.GC7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 11/07/2018 21:59, Eduardo Habkost wrote:
> 
> What exactly guarantees there will be no other references to
> (e.g.) `&s->control` when `s` is freed?
> 
> We know the references added by object_initialize(),
> object_property_add_child() and qdev_set_parent_bus() will be
> dropped, but what about other code calling object_ref()?

That would be a bug.  This is in fact the reason why
memory_region_ref/unref exists---to take the reference on the "outer"
device object rather than the contained memory region object.  It's not
pretty though.

I've thought of generalizing the pattern to Object (object_ref adds a
reference to the container rather than the contained object, and
finalize takes care of finalizing the contained object too), but I'm a
bit wary of doing it since it would complicate things further and
(except for MemoryRegions) it hasn't been a problem in practice.

Paolo
