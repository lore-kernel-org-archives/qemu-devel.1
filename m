Received: from eggs.gnu.org ([2001:4830:134:3::10]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsnRl-0003tX-42
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsnRh-0004jp-Lf
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:06:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsnRh-0004jl-FV
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:06:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E981A40006EC
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 11:06:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180823095359.GH23703@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Thu, 23 Aug 2018 10:53:59 +0100")
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-8-quintela@redhat.com>
	<0d3a215b-4916-b0a6-5654-5d64fcf6c996@redhat.com>
	<87y3cyo4ax.fsf@trasno.org>
	<20180823074321.wx7wix7jwsfrcbk5@sirius.home.kraxel.org>
	<9cb5f027-e49c-d943-7ffa-9e744537f174@redhat.com>
	<20180823094850.zycuwtjndmztgcm4@sirius.home.kraxel.org>
	<20180823095359.GH23703@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 23 Aug 2018 13:06:19 +0200
Message-ID: <87efepqr4k.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/10] check: Only test boot-serial when
 sga is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Aug 23, 2018 at 11:48:50AM +0200, Gerd Hoffmann wrote:
>> > > I remember we even discussed that a while back ...
>> > > Oh yes:
>> > > https://git.kraxel.org/cgit/qemu/commit/?h=3Dwork/no-sgabios&id=3D40=
8690999429fdf44011c49b3af6efa50f369b1e
>> > > Somehow never ended up being merged.
>> >=20
>> > Sounds like a good idea! Could you repost the patch, with an update to
>> > qemu-deprecated.texi, please? Maybe also print the deprecation message
>> > in any case if !use_sgabios, e.g.:
>> >=20
>> >     } else {
>> >         /*
>> >          * For this machine type we expect SeaBIOS to provide a
>> >          * serial console for -machine graphics=3Doff.  No need to
>> >          * add the sgabios rom here.
>> >          */
>> >         warn_report("sgabios is deprecated and is not required anymore=
,"
>> >                     " SeaBIOS now has the same functionality, too");
>> >     }
>>=20
>> Hmm, IIRC libvirt support is a bit tricky here as there is no easy way
>> to probe for serial console support in seabios.  So the idea was to just
>> allow both -machine graphics=3Doff and -device sga, by turning -device s=
ga
>> into a nop in case -machine graphics=3Doff is present.
>>=20
>> But given we meanwhile had some releases without this I suspect that
>> isn't a good idea any more.  With both -machine graphics=3Doff -device s=
ga
>> seabios and sgabios will fight over the serial device ...
>>=20
>> So, maybe take a completely different route.  Add a deprecation_reason
>> field to DeviceClass.  Make it visible in qapi introspection, so libvirt
>> can see it and avoid adding it to the command line.  Then we can
>> deprecate -device sga (and possibly other devices too) that way.
>
> That won't work IIUC. If we stop using "-device sga" based on some
> introspected deprecation value on the device, that means the guest
> will have a different ABI from POV of migration stream. So we would
> be unable to migrate to a QEMU without the deprecation, despite the
> XML config being unchanged.
>
> The only way we can stop using "-device sga" is if we either have
> something explicit in the XML saying whether to use it or not, or
> alternatively have some indicator associated with the next versioned
> machine type that we can hook off.

I think this is the only sane way to go.  From machine type X.Y, device
whatever is no longer available.  That work for all devices, make live
migration working, and we are sure that we are not using the
"deprecated" device on new machines.

Later, Juan.
