Received: from eggs.gnu.org ([2001:4830:134:3::10]:33063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9R8c-0000o5-1b
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9R8Y-0007hP-Qf
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:11:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f9R8Y-0007gk-M6
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:11:18 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<87po2wzysh.fsf@dusky.pond.sub.org>
	<8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com>
	<87in8nvdpn.fsf@dusky.pond.sub.org> <20180419075629.GC10259@redhat.com>
	<5ed8b01f-7faa-b23d-5fd2-f4715294e061@redhat.com>
	<20180419091201.GI10259@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a9006770-b4e3-cf57-3efa-c967740f7a94@redhat.com>
Date: Fri, 20 Apr 2018 10:11:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180419091201.GI10259@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

On 04/19/18 11:12, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Apr 19, 2018 at 10:39:32AM +0200, Laszlo Ersek wrote:
>> On 04/19/18 09:56, Daniel P. Berrang=C3=A9 wrote:
>>> On Thu, Apr 19, 2018 at 09:48:36AM +0200, Markus Armbruster wrote:
>>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>>
>>>>> On 04/18/18 10:47, Markus Armbruster wrote:
>>>>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>> Replacing CpuInfoArch by such an enum will change the discriminator
>>>> value from "other" to the real architecture, with the obvious
>>>> compatibility concerns.  But we've accepted similar changes twice
>>>> already: commit 9d0306dfdfb and commit 25fa194b7b1, both v2.12.0-rc0=
.
>>>>
>>>> "other" was a bad idea.  Hindsight 20/20.
>>>>
>>>> Getting rid of it in one go rather than piecemeal seems like the lea=
st
>>>> bad way out.  Too late for 2.12, though.  Eric, what do you think?
>>>
>>> Given the context in which this "other" value is used, I think it is
>>> reasonable to kill it and put a full arch list in there.
>>>
>>> No app is likely to be accessing the struct under "other" because it
>>> is just an empty placeholder.
>>
>> Commit 9d0306dfdfb added "s390" and "CpuInfoS390", which I guess had t=
he
>> potential to confuse QMP clients that didn't expect "s390", but
>> otherwise it didn't mess with preexistent enum values / structures.
>=20
> NB, qemu-system-s390x would previously have returned "other" in
> this field, and now it returns "s390".  So while it didn't
> remove "other" from the list of things that could potentially
> exist, it did change what the s390x binary will actually report.
>=20
>> The same applies to commit 25fa194b7b1, just with "riscv" /
>> "CpuInfoRISCV" substituted.
>>
>> Removing "other" might confuse QMP clients that expect it, except
>> (according to Daniel) no such client exists, probably.
>=20
> When I say removing "other", I imply that we add an explicit arch
> for all those which we currently are missing. IOW, all qemu-system-XXX
> binaries which currently report "other" would change to report their
> respective "XXX" values.
>=20
> So in this way, it is exactly the same as what we did when we
> introduced "s390" as an option.
>=20
> The only difference is that once we have every binary reporting the
> correct arch, we can now also remove "other" from the schema itself
> as it will then be unused.

Can we please translate this into more actionable items for me, because
I'm getting confused :)

First, if I add "i386" and "x86_64" to the enum list, we'll have all
three of "i386", "x86_64" and "x86". Is that useful? How will that work?

Second, assuming I add constants for the ~10 (?) softmmu arches, can I
still use @CpuInfoOther as the type for the corresponding new members in
@CpuInfo? What C code changes will be necessary?

Thanks
Laszlo
