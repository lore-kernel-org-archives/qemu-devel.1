Received: from eggs.gnu.org ([2001:4830:134:3::10]:38302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eOPQb-0000em-1S
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eOPQX-0004lp-Un
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:51:33 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:9537)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eOPQX-0004ki-IQ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:51:29 -0500
Date: Mon, 11 Dec 2017 15:51:26 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20171211145126.x3kxccyso7irle6x@var.youpi.perso.aquilenet.fr>
References: <20171211001950.27843-1-samuel.thibault@ens-lyon.org>
	<f0cb9660-757c-385f-ace7-73330014e733@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0cb9660-757c-385f-ace7-73330014e733@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] baum: Truncate braille device size to 84x1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com

Eric Blake, on lun. 11 déc. 2017 08:30:39 -0600, wrote:
> On 12/10/2017 06:19 PM, Samuel Thibault wrote:
> > Baum device bigger than 84 do not actually exist, some guest drivers
> > would be upset by such sizes.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > ---
> >  chardev/baum.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> 
> > @@ -239,6 +239,12 @@ static int baum_deferred_init(BaumChardev *baum)
> >          brlapi_perror("baum: brlapi__getDisplaySize");
> >          return 0;
> >      }
> > +    if (baum->y > 1) {
> > +        baum->y = 1;
> > +    }
> > +    if (baum->x > 84) {
> > +        baum->x = 84;
> > +    }
> 
> Is magic clamping desirable, or is it better to make it a hard error if
> the user configured a size that is not possible?

The thing is: the user didn't configure something, she just happened to
use a braille device bigger than 84 to display qemu's braille output.

This is the same situation as for the virtual video card: qemu could
expose resolutions as big as the size of the X display where qemu is
running on, but it's not a good idea to expose them all because some
drivers could go crazy with sizes bigger than what is supposed to be
supported by the hardware (or just assume the device is bogus and refuse
to drive it), and one should thus rather clamp them to what an actual
video device would support.

Samuel
