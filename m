Received: from eggs.gnu.org ([2001:4830:134:3::10]:37218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwqvu-0003bG-Rc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwqvp-00034v-3X
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:33:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwqvo-00033d-Qk
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:33:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2103C0587EF
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 14:33:51 +0000 (UTC)
References: <1504776162-31400-1-git-send-email-thuth@redhat.com>
	<20170921175650.GJ21016@localhost.localdomain>
	<1983cfd3-557a-c7ff-6fab-446efa6cf5d4@redhat.com>
	<20170926134139.GM21016@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3c522b57-9908-8c9f-09fd-24b49f0a8b0b@redhat.com>
Date: Tue, 26 Sep 2017 16:33:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170926134139.GM21016@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/qdev: Do not allow hot-plugging
 without hotplug controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 26.09.2017 15:41, Eduardo Habkost wrote:
> On Tue, Sep 26, 2017 at 12:05:47PM +0200, Thomas Huth wrote:
>> On 21.09.2017 19:56, Eduardo Habkost wrote:
>>> On Thu, Sep 07, 2017 at 11:22:42AM +0200, Thomas Huth wrote:
>>>> qdev_unplug() bails out with an assertion if the user tries to devic=
e_del
>>>> a hot-plugged device that does not have a hotplug controller. Unfort=
unately,
>>>> our devices are all marked with hotpluggable =3D true by default (se=
e the
>>>> device_class_init() function in qdev.c), so it currently can happen =
that
>>>> the user runs into this situation and QEMU gets terminated unexpecte=
dly:
>>>>
>>>> $ qemu-system-aarch64 -M virt -nographic -nodefaults -monitor stdio =
-S
>>>> QEMU 2.10.50 monitor - type 'help' for more information
>>>> (qemu) device_add aux-to-i2c-bridge,id=3Dx
>>>> (qemu) device_del x
>>>> **
>>>> ERROR:qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctr=
l)
>>>> Aborted (core dumped)
>>>>
>>>> Hotplugging devices without a hotplug controller does not make much =
sense,
>>>> so we should disallow this during the device_add process already!
>>>>
>>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> I'm queueing this on machine-next.  We still want it even if we
>>> apply the patch that changes TYPE_DEVICE to hotpluggable=3Dfalse by
>>> default, right?
>>
>> OK, just to be sure: Please de-queue it again. As you already mentione=
d
>> in another mail, there are situations where this does not work (e.g.
>> when one hot-pluggable device wants to instantiate another hot-pluggab=
le
>> device internally).
>=20
> I just dequeued it.
>=20
>>
>> But maybe we could add the test for the availability of a hot-plug
>> controller to qmp_device_add() instead? (I haven't had a closer look a=
t
>> that yet, though).
>=20
> I'm unsure about this.  Now we know we have some devices that
> work without a hotplug controller, so what's the reason
> device_add must always require one?

The problem is that you can also "device_del" these devices again. And
qdev_unplug() currently has this piece of code in it:

    /* hotpluggable device MUST have HotplugHandler, if it doesn't
     * then something is very wrong with it */
    g_assert(hotplug_ctrl);

So if you do a device_add followed by a device_del with one of these
devices, QEMU aborts and kills your guest.

One solution is maybe to remove the assert here. OTOH, considering that
we have the assert in qdev_monitor.c->qdev_unplug(), adding a check for
the availability of a hotplug_ctrl in qdev_monitor.c->qmp_device_add()
currently sounds like the better solution to this problem to me. Anybody
got another opinion here? If not, I'll have a try and send a patch...

 Thomas
