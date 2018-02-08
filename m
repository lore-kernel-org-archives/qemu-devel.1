Received: from eggs.gnu.org ([2001:4830:134:3::10]:43769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejjvV-0005bX-MM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejjvQ-00078q-2m
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:59:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejjvP-00078Z-UL
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:59:32 -0500
Date: Thu, 8 Feb 2018 11:59:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180208115914.7df7bf87@redhat.com>
In-Reply-To: <CAF6HrYx6fKVAACMN1TFV_9xKU42RP1yULQpwjvV9jtDExZq8JA@mail.gmail.com>
References: <CAF6HrYx6fKVAACMN1TFV_9xKU42RP1yULQpwjvV9jtDExZq8JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Questions regarding how QEMU initializes virtual
 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ramy Sameh <ramysameh26@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mona Safar <Mona.Safar@eng.asu.edu.eg>, Watheq <watheq@gmail.com>, Ahmed Aly <ahmedaly50@gmail.com>

On Thu, 8 Feb 2018 12:06:44 +0200
Ramy Sameh <ramysameh26@gmail.com> wrote:

> Hello all,
> 
> I am working with QEMU to simulate VersatilePB board.
> 
> I am trying to understand how QEMU initialize the virtual peripherals (e.g.
> UART, vectored Interrupt controller .. etc).
> 
> When I traced the code, I found a function called "object_init_with_type"
> in object.c, in which the function pointer "ti->instance_init(obj)" seems
> to call the peripherals initialization functions.
> 
> *I have couple of questions here:*
> 1.) Some peripheral initialization functions are called multiple times such
> as pl011_init, why is that ?
function is called once for each instance of pl011 object.

QEMU uses custom OOM framework (dubbed QOM), good point to start with it
is probably to read doc comment in the beginning of include/qom/object.h

Device objects are typically inherited from TYPE_DEVICE or its derivatives.
Device init sequence typically looks like:
   foo = object_new(TYPE_FOO);
   // set_properties on foo, see object_property_set_...

   // and set special property 'realize' which would call 'realize' method
   object_property_set_bool(foo, true, "realized");

See qdev_device_add() for details

> 2.) Where is the entry point for the whole initialization functionalities
> (that will eventually call "object_init_with_type")

object_new() & co + object_initialize_with_type()

> Thank you.
> 
