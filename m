Received: from eggs.gnu.org ([209.51.188.92]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0m2E-0002Ws-2m
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0m2C-0005f5-3a
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:45:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<87va0zcdse.fsf@dusky.pond.sub.org> <20190304101911.GE4239@redhat.com>
Date: Mon, 04 Mar 2019 12:45:14 +0100
In-Reply-To: <20190304101911.GE4239@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Mon, 4 Mar 2019 10:19:11 +0000")
Message-ID: <87y35u3lth.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] numa: deprecate 'mem'
 parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, david@gibson.dropbear.id.au

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Mar 04, 2019 at 08:13:53AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Mar 01, 2019 at 06:33:28PM +0100, Igor Mammedov wrote:
>> >> On Fri, 1 Mar 2019 15:49:47 +0000
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>> >>=20
>> >> > On Fri, Mar 01, 2019 at 04:42:15PM +0100, Igor Mammedov wrote:
>> >> > > The parameter allows to configure fake NUMA topology where guest
>> >> > > VM simulates NUMA topology but not actually getting a performance
>> >> > > benefits from it. The same or better results could be achieved
>> >> > > using 'memdev' parameter. In light of that any VM that uses NUMA
>> >> > > to get its benefits should use 'memdev' and to allow transition
>> >> > > initial RAM to device based model, deprecate 'mem' parameter as
>> >> > > its ad-hoc partitioning of initial RAM MemoryRegion can't be
>> >> > > translated to memdev based backend transparently to users and in
>> >> > > compatible manner (migration wise).
>> >> > >=20
>> >> > > That will also allow to clean up a bit our numa code, leaving only
>> >> > > 'memdev' impl. in place and several boards that use node_mem
>> >> > > to generate FDT/ACPI description from it.=20=20
>> >> >=20
>> >> > Can you confirm that the  'mem' and 'memdev' parameters to -numa
>> >> > are 100% live migration compatible in both directions ?  Libvirt
>> >> > would need this to be the case in order to use the 'memdev' syntax
>> >> > instead.
>> >> Unfortunately they are not migration compatible in any direction,
>> >> if it where possible to translate them to each other I'd alias 'mem'
>> >> to 'memdev' without deprecation. The former sends over only one
>> >> MemoryRegion to target, while the later sends over several (one per
>> >> memdev).
>> >
>> > If we can't migration from one to the other, then we can not deprecate
>> > the existing 'mem' syntax. Even if libvirt were to provide a config
>> > option to let apps opt-in to the new syntax, we need to be able to
>> > support live migration of existing running VMs indefinitely. Effective=
ly
>> > this means we need the to keep 'mem' support forever, or at least such
>> > a long time that it effectively means forever.
>> >
>> > So I think this patch has to be dropped & replaced with one that
>> > simply documents that memdev syntax is preferred.
>>=20
>> We have this habit of postulating absolutes like "can not deprecate"
>> instead of engaging with the tradeoffs.  We need to kick it.
>>=20
>> So let's have an actual look at the tradeoffs.
>>=20
>> We don't actually "support live migration of existing running VMs
>> indefinitely".
>>
>> We support live migration to any newer version of QEMU that still
>> supports the machine type.
>>=20
>> We support live migration to any older version of QEMU that already
>> supports the machine type and all the devices the machine uses.
>>=20
>> Aside: "support" is really an honest best effort here.  If you rely on
>> it, use a downstream that puts in the (substantial!) QA work real
>> support takes.
>
> If upstream deletes the feature, then that in turn breaks the downstream
> unless downstream reverts the upstream change. When we have large overlap
> between downstream & upstream maintainer, it is not beneficial to delete
> the feature upstream as any effort saved upstream usually expands into
> larger effort downstream.

It can't "break" existing downstreams, only future ones forked off after
the deletion.  Such a fork cares only if it has backward compatibility
requirements to satisfy that require the feature.  My point is: it's not
a simple absolute, it's a complex tradeoff.

>> Feature deprecation is not a contract to drop the feature after two
>> releases, or even five.  It's a formal notice that users of the feature
>> should transition to its replacement in an orderly manner.
>>=20
>> If I understand Igor correctly, all users should transition away from
>> outdated NUMA configurations at least for new VMs in an orderly manner.
>>=20
>> So, how could this formal notice be served constructively?
>>=20
>> If we reject outdated NUMA configurations starting with machine type T,
>> we can remove the means to create those configurations along with
>> machine type T-1.  Won't happen anytime soon, will happen eventually,
>> because in the long run, all machine types are dead (apologies to
>> Keynes).
>>=20
>> If we deprecate outdated NUMA configurations now, we can start rejecting
>> them with new machine types after a suitable grace period.
>
> How is libvirt going to know what machines it can use with the feature ?
> We don't have any way to introspect machine type specific logic, since we
> run all probing with "-machine none", and QEMU can't report anything about
> machines without instantiating them.

Fair point.  A practical way for management applications to decide which
of the two interfaces they can use with which machine type may be
required for deprecating one of the interfaces with new machine types.
