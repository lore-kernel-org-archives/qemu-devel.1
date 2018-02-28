Received: from eggs.gnu.org ([2001:4830:134:3::10]:37630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1er2wj-0007Qt-QA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1er2wg-0008Ua-O3
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:43:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1er2wg-0008T1-Is
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:43:02 -0500
Message-ID: <1519828976.3345.29.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 28 Feb 2018 15:42:56 +0100
In-Reply-To: <20180226082259.40293-1-aik@ozlabs.ru>
References: <20180226082259.40293-1-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, 2018-02-26 at 19:22 +1100, Alexey Kardashevskiy wrote:
> There is already 'device-list-properties' which does most of the job,
> however it does not handle everything returned by qom-list-types such
> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
> It does not handle abstract classes either.
> 
> This adds a new qom-list-properties command which prints properties
> of a specific class and its instance. It is pretty much a simplified copy
> of the device-list-properties handler.
> 
> Since it creates an object instance, device properties should appear
> in the output as they are copied to QOM properties at the instance_init
> hook.
> 
> This adds a object_class_property_iter_init() helper to allow class
> properties enumeration uses it in the new QMP command to allow properties
> listing for abstract classes.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * added abstract classes support, now things like "pci-device" or
> "spapr-machine" show properties, previously these would produce
> an "abstract class" error

This is really nice, since it means libvirt won't have to figure
out the class name based on the default machine type but will be
able to simply list properties for the base class.

I'm going to implement support for this new command in libvirt
and report back if I run into any issue with the current design,
but it looks very good so far.

-- 
Andrea Bolognani / Red Hat / Virtualization
