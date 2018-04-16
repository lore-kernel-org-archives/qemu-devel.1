Received: from eggs.gnu.org ([2001:4830:134:3::10]:42278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f871y-0005n8-Bg
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f871v-0000o4-OM
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:31:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f871v-0000nw-K6
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:30:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180416111743.8473-1-berrange@redhat.com>
Date: Mon, 16 Apr 2018 18:30:45 +0200
In-Reply-To: <20180416111743.8473-1-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 16 Apr 2018 12:17:40
	+0100")
Message-ID: <87muy3m7uy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Remove artificial length limits when
 parsing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> A user trying out SMBIOS "OEM strings" feature reported that the data
> they are exposing to the guest was truncated at 1023 bytes, which breaks
> the app consuming in the guest. After searching for the cause I
> eventually found that the QemuOpts parsing is using fixed length 1024
> byte array for option values and 128 byte array for key names.
>
> We can certainly debate whether it is sane to have such long command
> line argument values (it is not sane), but if the OS was capable of
> exec'ing QEMU with such an ARGV array, there is little good reason for
> imposing an artificial length restriction when parsing it. Even worse is
> that we silently truncate without reporting an error when hitting limits
> resulting in a semantically incorrect behaviour, possibly even leading
> to security flaws depending on the data that was truncated.
>
> Thus this patch series removes the artificial length limits by killing
> the fixed length buffers.
>
> Separately I intend to make it possible to read "OEM strings" data from
> a file, to avoid need to have long command line args.

Too bad I haven't been able to complete my quest to kill QemuOpts.

As far as I know, keyval.c's only arbitrary limit is the length of a key
fragment (the things separated by '.').
