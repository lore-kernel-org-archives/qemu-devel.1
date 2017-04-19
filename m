Received: from eggs.gnu.org ([2001:4830:134:3::10]:40579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d0iYe-0006TK-Ja
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 01:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d0iYb-0001RF-Fp
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 01:53:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d0iYb-0001Q5-9g
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 01:53:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
	<20170403141912.GA3539@stefanha-x1.localdomain>
	<87fuhf9kcz.fsf@dusky.pond.sub.org>
	<20170418095103.GF21261@stefanha-x1.localdomain>
	<1492516675.27392.45.camel@redhat.com>
	<7ae1e13f-b6a0-a735-3952-4e3833e34ad8@redhat.com>
Date: Wed, 19 Apr 2017 07:53:28 +0200
In-Reply-To: <7ae1e13f-b6a0-a735-3952-4e3833e34ad8@redhat.com> (John Snow's
	message of "Tue, 18 Apr 2017 13:18:14 -0400")
Message-ID: <87r30prlif.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 04/18/2017 07:57 AM, Gerd Hoffmann wrote:
>>   Hi,
>> 
>>>> Just like -device is a general way to plug in devices, replacing
>>>> multiple special ways (-net, -drive, -usb, ...), we could use a general
>>>> way to configure onboard devices.
>>>
>>> I looked at the -device implementation to see if the bus= parameter
>>> could be used to specify onboard device addresses, but I think you may
>>> be right that we need a separate command-line argument for onboard
>>> devices.
>> 
>> I think so.
>> 
>> There is -global, which is actually used by libvirt to configure
>> built-in floppy devices.  But as the name suggests it sets properties
>> globally, i.e. for all instances.  Which works in this specific use
>> case, as there can be only one floppy controller per machine, but I
>
> Spec-wise, Can't you have two?

You can, but approximately nobody wants to.

>> don't think this is something we want build on.
>> 
>> There is -set, but that works only for devices created via -device,
>> because it operates on QemuOpts, and we don't have QemuOpts for built-in
>> devices.

Yes.  QAPIfying the command line wouldn't change that.

>> We probably want something like
>>   -qom-set-property {objpath|alias}.prop=value

Makes sense to me.

We should be able to desugar -net, ... to -qom-set-property then.
However, the desugaring would be machine-specific in general.  Machines
would need to provide data or code to guide the desugaring, replacing
their code that rummages through global configuration such as
nd_table[].  Sounds like an improvement to me.
