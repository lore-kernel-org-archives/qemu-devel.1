Received: from eggs.gnu.org ([2001:4830:134:3::10]:58079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzLKl-0007m0-VA
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 08:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzLKi-0007nx-HS
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 08:30:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzLKi-0007n5-5x
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 08:30:24 -0400
Date: Mon, 10 Sep 2018 08:30:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180910123020.GA19941@flamenco>
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-6-cota@braap.org> <87d0tld83i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0tld83i.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 5/6] target/i386/translate: use
 thread-local storage in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Sep 10, 2018 at 10:17:53 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Needed for MTTCG.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  target/i386/translate.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/target/i386/translate.c b/target/i386/translate.c
> > index 1f9d1d9b24..9a6a72e205 100644
> > --- a/target/i386/translate.c
> > +++ b/target/i386/translate.c
> > @@ -71,26 +71,34 @@
> >  
> >  //#define MACRO_TEST   1
> >  
> > +/* we need thread-local storage for mttcg */
> > +#ifdef CONFIG_USER_ONLY
> > +#define I386_THREAD
> > +#else
> > +#define I386_THREAD __thread
> > +#endif
> > +
> 
> I'm confused - as we can have multi-threaded user space don't the same
> requirements apply?

In user-mode, code generation is serialized by mmap_lock.
Making these per-thread would just waste TLS space.

		E.
