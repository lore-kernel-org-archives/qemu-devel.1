Received: from eggs.gnu.org ([2001:4830:134:3::10]:37371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fskcH-00056y-Ro
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fskcE-0003ng-J3
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:05:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fskcE-0003mA-6u
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:05:14 -0400
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-8-quintela@redhat.com>
	<0d3a215b-4916-b0a6-5654-5d64fcf6c996@redhat.com>
	<87y3cyo4ax.fsf@trasno.org>
	<20180823074321.wx7wix7jwsfrcbk5@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9cb5f027-e49c-d943-7ffa-9e744537f174@redhat.com>
Date: Thu, 23 Aug 2018 10:05:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180823074321.wx7wix7jwsfrcbk5@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 2018-08-23 09:43, Gerd Hoffmann wrote:
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Off-topic: I wonder whether we could even deprecate the SGA device
>>> nowadays, since the main seabios now can redirect the console to the
>>> serial port, too?
>>
>> No idea, but then I think we can deprecate it, we already have enough
>> weird things around.
>=20
> Deprecating sure.  Actually dropping is not so easy I think.  The switc=
h
> is not transparent to the guest, which implies live migration
> compatibility isssues.
>=20
> So the only thing we can do is blocking it for new machine types (3.1+)=
.
> Then, in a bunch of years when we deprecate 3.1 & older machine types,
> we can actually remove it.
>=20
> I remember we even discussed that a while back ...
> Oh yes: https://git.kraxel.org/cgit/qemu/commit/?h=3Dwork/no-sgabios&id=
=3D408690999429fdf44011c49b3af6efa50f369b1e
> Somehow never ended up being merged.

Sounds like a good idea! Could you repost the patch, with an update to
qemu-deprecated.texi, please? Maybe also print the deprecation message
in any case if !use_sgabios, e.g.:

    if (sga->use_sgabios) {
        rom_add_vga(SGABIOS_FILENAME);
    } else if (machine->enable_graphics) {
        warn_report("sgabios is deprecated for your machine type, "
                    "please use -machine graphics=3Doff instead of "
                    "-device sga");
        rom_add_vga(SGABIOS_FILENAME);
    } else {
        /*
         * For this machine type we expect SeaBIOS to provide a
         * serial console for -machine graphics=3Doff.  No need to
         * add the sgabios rom here.
         */
        warn_report("sgabios is deprecated and is not required anymore,"
                    " SeaBIOS now has the same functionality, too");
    }

 Thomas
