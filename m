Received: from eggs.gnu.org ([2001:4830:134:3::10]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f6Z9S-0005bD-Rl
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f6Z9P-00052a-Ig
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:08:22 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:39219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f6Z9P-00051h-8e
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:08:19 -0400
Received: by mail-io0-x22c.google.com with SMTP id v13so5682580iob.6
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 03:08:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180412082822.GC31024@redhat.com>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
	<1523089594-1422-3-git-send-email-lidongchen@tencent.com>
	<20180411171818.GJ2667@work-vm> <20180412082822.GC31024@redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 12 Apr 2018 18:08:18 +0800
Message-ID: <CAOGPPbfwBP2Asqc2TE0CoMVxAB5sRpMb45dyRxkgUUL-3N+eTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: add the interface to set
 get_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Thu, Apr 12, 2018 at 4:28 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Wed, Apr 11, 2018 at 06:18:18PM +0100, Dr. David Alan Gilbert wrote:
>> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> > The default get_return_path function of iochannel does not work for
>> > RDMA live migration. So add the interface to set get_return_path.
>> >
>> > Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>
>> Lets see how Dan wants this done, he knows the channel/file stuff;
>> to me this feels like it should be adding a member to QIOChannelClass
>> that gets used by QEMUFile's get_return_path.
>
> No that doesn't really fit the model. IMHO the entire concept of a separa=
te
> return path object is really wrong. The QIOChannel implementations are
> (almost) all capable of bi-directional I/O, which is why the the get_retu=
n_path
> function just creates a second QEMUFile pointing to the same QIOChannel
> object we already had. Migration only needs the second QEMUFile, because =
that
> struct re-uses the same struct fields for tracking different bits of info
> depending on which direction you're doing I/O in. A real fix would be to
> stop overloading the same fields for multiple purposes in the QEMUFile, s=
o
> that we only needed a single QEMUFile instance.
>
> Ignoring that though, the particular problem we're facing here is that th=
e
> QIOChannelRDMA impl that is used is not written in a way that allows
> bi-directional I/O, despite the RDMA code it uses being capable of it.
>
> So rather than changing this get_return_path code, IMHO, the right fix to
> simply improve the QIOChannelRDMA impl so that it fully supports bi-direc=
tional
> I/O like all the other channels do.

Hi Daniel:
     Thanks for your suggestion.
     I will have a try.

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
