Received: from eggs.gnu.org ([2001:4830:134:3::10]:33601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwgZB-00030E-1d
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwgZ6-0004AO-Lu
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwgZ6-00049P-DT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:29:44 -0400
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
	<59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
	<20170925175944.GD3030@localhost.localdomain>
	<CAFEAcA_3SpWNm0FCviD5fXOFmxF1jGAwYgD_cZgwUMMAMn4BOQ@mail.gmail.com>
	<20170926025956.GB4115@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d5dcbb18-3ff8-f47d-8b15-8f7473165335@redhat.com>
Date: Tue, 26 Sep 2017 05:29:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170926025956.GB4115@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On 26.09.2017 04:59, Eduardo Habkost wrote:
> On Mon, Sep 25, 2017 at 07:05:26PM +0100, Peter Maydell wrote:
>> On 25 September 2017 at 18:59, Eduardo Habkost <ehabkost@redhat.com> w=
rote:
>>> Finding the full list of devices that can be instantiated
>>> internally at hotplug-time sounds tricky.
>>
>> If we just diff "list of devices marked hotplug before this patch"
>> against "list of devices marked hotplug after this patch" how
>> big is the list? Can we just eyeball it to see what needs
>> to be specialcased?
>=20
> So, the full list quite big, ~1800 device types are affected by
> this patch:
>=20
> https://gist.github.com/ehabkost/bd8e25c6811ac81d947ad8ad5b557f5c#file-=
dev-types-diff-json
>=20
> If we ignore the "-cpu" classes, there ~640 affected device
> types.
>=20
> However, if we look only at the direct children of TYPE_DEVICE,
> we have:

OK, thanks a lot for that list! But do you think that we can assume that
the devices which are not direct children of TYPE_DEVICE can not be
hotplugged internally during runtime? ... I currently don't think so
(but at least they are good candidates which need to be examined more
carefully).

But anyway, how can we continue here? Set hotpluggable =3D true on all 64=
0
(or even all 1800) affected devices? That sounds very, very ugly to me.
Maybe we should just do it for the virtio-*-device devices and the
others that break during "make check" (btw. sorry for not noticing this
... I normally run "make check" regularly, but this time I apparently
missed to run it for aarch64), and if we later notice some more
problems, we know that we lack a "make check" test for that case, too,
and we should add such a test? That would at least eventually improve
our test coverage a little bit, I guess...

 Thomas
