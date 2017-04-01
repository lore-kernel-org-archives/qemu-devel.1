Received: from eggs.gnu.org ([2001:4830:134:3::10]:37115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuLHP-0006P5-9p
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 11:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuLHN-0005mP-Nb
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 11:49:31 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuLHN-0005ll-EP
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 11:49:29 -0400
Received: by mail-oi0-x241.google.com with SMTP id t11so13512973oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 08:49:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4a433007-eced-0128-f6c9-adffa2d88a9e@redhat.com>
References: <CA+KKJYBN3Gu5jzToi61Qf2Un7jOTzB0HcfREnniUQhTe9B=GGg@mail.gmail.com>
	<4a433007-eced-0128-f6c9-adffa2d88a9e@redhat.com>
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 18:49:28 +0300
Message-ID: <CA+KKJYDoqTP9SAa2a4hp0u_NiqYw82exFavZ7jYk1V9QjEhp-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 02/43] arm: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, balrogg@gmail.com

Thanks for review. I'll update and resend these pathces (probably next
week).

2017-04-01 17:51 GMT+03:00 Eric Blake <eblake@redhat.com>:

> On 04/01/2017 08:32 AM, Danil Antonov wrote:
> >>From 1671b92e5a4a59d5e38ce754d1d0dde2401c8236 Mon Sep 17 00:00:00 2001
> > From: Danil Antonov <g.danil.anto@gmail.com>
> > Date: Wed, 29 Mar 2017 02:09:33 +0300
> > Subject: [PATCH 02/43] arm: made printf always compile in debug output
> >
> > Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> > This will ensure that printf function will always compile even if debug
> > output is turned off and, in turn, will prevent bitrot of the format
> > strings.
>
> Again, prefer present tense over past tense in the commit message.
>
> >
> > Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
> > ---
> >  hw/arm/strongarm.c | 17 +++++++++++------
> >  hw/arm/z2.c        | 16 ++++++++++------
> >  2 files changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> > index 3311cc3..88368ac 100644
> > --- a/hw/arm/strongarm.c
> > +++ b/hw/arm/strongarm.c
> > @@ -59,11 +59,16 @@
> >   - Enhance UART with modem signals
> >   */
> >
> > -#ifdef DEBUG
> > -# define DPRINTF(format, ...) printf(format , ## __VA_ARGS__)
> > -#else
> > -# define DPRINTF(format, ...) do { } while (0)
> > -#endif
> > +#ifndef DEBUG
> > +#define DEBUG 0
> > +#endif
> > +
> > +#define DPRINTF(fmt, ...)                         \
> > +    do {                                          \
> > +        if (DEBUG) {                              \
> > +            fprintf(stderr, fmt, ## __VA_ARGS__); \
>
> Again, changing from stdout to stderr should be mentioned as intentional
> in the commit message.
>
> Note that your change breaks the case of someone that used to do:
>
> make CFLAGS=-DDEBUG=
>
> because now it results in 'if ()' which is not valid syntax; likewise
> for someone that used to do CFLAGS=-DDEBUG=yes.  (Or put another way, as
> written, your patch forces someone to use -DDEBUG=0 or -DDEBUG=1).  A
> safer way is to make the 'if' condition a separate variable than the
> command-line trigger, as in the following, so that regardless of what
> DEBUG is defined to (including the empty string), you are only using
> DEBUG in the preprocessor, while the if conditional is under your
> complete control:
>
> #ifdef DEBUG
> # define DEBUG_PRINT 1
> #else
> # define DEBUG_PRINT 0
> #endif
>
> #definde DPRINTF()... if (DEBUG_PRINT)
>
> > @@ -1022,7 +1027,7 @@ static void
> > strongarm_uart_update_parameters(StrongARMUARTState
> > *s)
> >      s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) *
> frame_size;
> >      qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
> >
> > -    DPRINTF(stderr, "%s speed=%d parity=%c data=%d stop=%d\n",
> > s->chr->label,
>
> Oh gross - the old code couldn't even compile correctly when DEBUG was
> defined (since printf(stderr) tries to treat the stderr pointer as a
> format string)!  This is a definite cleanup, and an argument that your
> switch from stdout to stderr is correct.
>
>
> > +++ b/hw/arm/z2.c
> > @@ -27,12 +27,16 @@
> >  #include "exec/address-spaces.h"
> >  #include "sysemu/qtest.h"
> >
> > -#ifdef DEBUG_Z2
> > -#define DPRINTF(fmt, ...) \
> > -        printf(fmt, ## __VA_ARGS__)
> > -#else
> > -#define DPRINTF(fmt, ...)
> > -#endif
> > +#ifndef DEBUG_Z2
> > +#define DEBUG_Z2 0
> > +#endif
> > +
> > +#define DPRINTF(fmt, ...)                                \
> > +    do {                                                 \
> > +        if (DEBUG_Z2) {                                  \
>
> Again, it's best to separate your conditional to be something completely
> under you control, while still allowing the command line freedom to
> define DEBUG_Z2 to anything (whether an empty string or a non-numeric
> value).
>
> These types of comments probably apply throughout your entire series, so
> it may be better if I wait for a v2 before reviewing too many more.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
>
