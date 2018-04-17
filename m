Received: from eggs.gnu.org ([2001:4830:134:3::10]:60204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1f8W1T-0007Yj-Qr
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1f8W1Q-0004il-Gr
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:12:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1f8W1Q-0004iV-Ac
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:12:08 -0400
References: <20170911165929.2791-3-marcandre.lureau@redhat.com>
	<20171009110336.GA17824@redhat.com>
	<20171009144344.38bbd1e9@nial.brq.redhat.com>
	<20171009130218.GK2954@redhat.com>
	<20171010003951-mutt-send-email-mst@kernel.org>
	<20171010083143.GA30015@redhat.com>
	<CAJ+F1CLGJLXYnJ8SnrbVkWc6bdU2geYKeEaKrxWaYBhXwA=Opg@mail.gmail.com>
	<20171010150628.GI30015@redhat.com>
	<20171010180110.GI3246@localhost.localdomain>
	<20171015044800-mutt-send-email-mst@kernel.org>
	<20171020184820.GP2942@localhost.localdomain>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <a5ff2864-f794-e728-5be1-0c1e58d9f163@redhat.com>
Date: Tue, 17 Apr 2018 15:12:03 -0400
MIME-Version: 1.0
In-Reply-To: <20171020184820.GP2942@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/7] hw/misc: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Dave Anderson <anderson@redhat.com>

On 10/20/2017 02:48 PM, Eduardo Habkost wrote:
> On Sun, Oct 15, 2017 at 04:56:28AM +0300, Michael S. Tsirkin wrote:
>> On Tue, Oct 10, 2017 at 03:01:10PM -0300, Eduardo Habkost wrote:
>>> On Tue, Oct 10, 2017 at 04:06:28PM +0100, Daniel P. Berrange wrote:
>>>> On Tue, Oct 10, 2017 at 05:00:18PM +0200, Marc-Andr=C3=A9 Lureau wro=
te:
>>>>> Hi
>>>>>
>>>>> On Tue, Oct 10, 2017 at 10:31 AM, Daniel P. Berrange
>>>>> <berrange@redhat.com> wrote:
>>>>>> On Tue, Oct 10, 2017 at 12:44:26AM +0300, Michael S. Tsirkin wrote=
:
>>>>>>> On Mon, Oct 09, 2017 at 02:02:18PM +0100, Daniel P. Berrange wrot=
e:
>>>>>>>> On Mon, Oct 09, 2017 at 02:43:44PM +0200, Igor Mammedov wrote:
>>>>>>>>> On Mon, 9 Oct 2017 12:03:36 +0100
>>>>>>>>> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>>> On Mon, Sep 11, 2017 at 06:59:24PM +0200, Marc-Andr=C3=A9 Lure=
au wrote:
>>>>>>>>>>> See docs/specs/vmcoreinfo.txt for details.
>>>>>>>>>>>
>>>>>>>>>>> "etc/vmcoreinfo" fw_cfg entry is added when using "-device vm=
coreinfo".
>>>>>>>>>>
>>>>>>>>>> I'm wondering if you considered just adding the entry to fw_cf=
g by
>>>>>>>>>> default, without requiring any -device arg ? Unless I'm misund=
erstanding,
>>>>>>>>>> this doesn't feel like a device to me - its just a well known =
bucket
>>>>>>>>>> in fw_cfg IIUC ?  Obviously its existance would need to be tie=
d to
>>>>>>>>>> the latest machine type for ABI reasons though. The benefit of=
 this
>>>>>>>>>> is that it would "just work" without us having to plumb it thr=
ough to
>>>>>>>>>> all the downstream applications that use QEMU for mgmt guest (=
OpenStack,
>>>>>>>>>> oVirt, GNOME Boxes, virt-manager, and countless other mgmt app=
s).
>>>>>>>>> it follows model set by pvpanic device, it's easier to manage f=
rom migration
>>>>>>>>> POV, one could use it even for old machine types with new qemu =
(just by adding
>>>>>>>>> device, it makes instance not backwards migratable to old qemu =
but should work
>>>>>>>>> for forward migration) and if user doesn't need it, device coul=
d be just omitted
>>>>>>>>> from CLI.
>>>>>>>>
>>>>>>>> Sure but it means that in effect no one will have this functiona=
lity enabled
>>>>>>>> for several years. pvpanic has been around a long time and I rar=
ely see it
>>>>>>>> present in configured guests :-(
>>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Daniel
>>>>>>>
>>>>>>> libvirt runs with -nodefaults, right? I'd argue pretty strongly -=
nodefaults
>>>>>>> shouldn't add optional devices anyway.
>>>>>>
>>>>>> This isn't really adding a device though is it - it is just a well=
 known
>>>>>> location in fw_cfg to receive data.
>>>>>
>>>>> Enabling the device on some configurations by default can be done a=
s a
>>>>> follow-up patch. Can we get this series reviewed & merged?
>>>>
>>>> The problem with the -device approach + turning it on by default is =
that there
>>>> is no way to turn it off again if you don't want it. eg there's way =
to undo
>>>> an implicit '-device foo' except via -nodefaults, but since libvirt =
uses that
>>>> already it would negate the effect of enabling it by default uncondi=
tionally.
>>>
>>> It's still possible to add a -machine option that can
>>> enable/disable automatic creation of the device.
>>>
>>> But I also don't see why it needs to be implemented using -device
>>> if it's not really a device.  A boolean machine or fw_cfg
>>> property is good enough for that.
>>
>> It certainly feels like a device. It has state
>> (that needs to be migrated), it has a host/guest interface.
>=20
> (Sorry for the late reply)
>=20
> That's convincing enough to me.  :)
>=20
>=20
>>>>
>>>> Your previous approach of "-global fw_cfg.vmcoreinfo=3Don" is nicer =
in this
>>>> respect, as you can trivially turn it on/off, overriding the default=
 state
>>>> in both directions.
>>>
>>> Both "-global fw_cfg.vmcoreinfo=3Don|off" and
>>> "-machine vmcoreinfo=3Don|off" sound good enough to me.
>>
>>
>> Certainly not a fw cfg flag. Can be a machine flag I guess
>> but then we'd have to open-code each such device.
>> And don't forget auto - this is what Daniel asks for.
>=20
> I'm not sure Daniel is really asking for "auto": he is just
> asking for a way to disable the new default.  If "vmcoreinfo=3Doff"
> and "vmcoreinfo=3Doff" works, there's no need for a user-visible
> "auto" value.
>=20
> (Actually, "auto" values makes compatibility code even messier,
> because we would need one additional compat property/field to
> tell QEMU what "auto" means on each machine)
>=20

Reviving this... did any follow up changes happen?

Marc-Andr=C3=A9 patched virt-manager a few months back to enable -device
vmcoreinfo for new VMs:

https://www.redhat.com/archives/virt-tools-list/2018-February/msg00020.ht=
ml

And I see there's at least a bug tracking adding this to openstack for
new VMs:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1555276

If this feature doesn't really have any downsides, it would be nice to
get this tied to new machine types. Saves a lot of churn for higher
levels of the stack

Thanks,
Cole
