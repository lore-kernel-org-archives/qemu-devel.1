Received: from eggs.gnu.org ([2001:4830:134:3::10]:58360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fdLWj-0003ZU-Ey
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fdLWi-0002ad-Gr
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:15:53 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
	<163e1c54-c953-e5fe-3142-eab18e0362b8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <016ebe6a-91e3-24f3-9e2a-26613bd9f61e@redhat.com>
Date: Wed, 11 Jul 2018 22:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <163e1c54-c953-e5fe-3142-eab18e0362b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 11/07/2018 20:43, Thomas Huth wrote:
>>
>> - realize fails
> In this case, the failure is before realize is attempted,
> qdev_device_add() already stop with "Device '%s' can not be hotplugged
> on this machine".

Still, object_unparent is called by qdev_device_add in the error path,
and it should work the same way (in a nutshell, recursive unparent when
child properties are deleted, and finalization of the contained objects
as the last reference is dropped).

>> - object_unparent is called on the device that failed to realize (see
>> qdev_device_add).  object_unparent calls device_unparent
> Hmm, are you sure? I can see that object_unparent calls device_unparent
> indirectly for the *child* nodes of the device, but not for the device
> itself...

object_unparent -> object_property_del_child ->
object_finalize_child_property -> device_unparent

I think you're on the right track, after object_property_add_child you
need to drop the reference to the object.  For example qmp_device_add
does it after qdev_device_add returns a device successfully (just an
example---I understand it is not the case with bcm283x).  In that case
the call to object_property_add_child is in qdev_set_id.

Paolo
