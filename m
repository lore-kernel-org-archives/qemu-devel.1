Received: from eggs.gnu.org ([2001:4830:134:3::10]:52955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df75m-0002xs-0w
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df75k-0007Ef-9f
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:10:49 -0400
Date: Tue, 8 Aug 2017 17:10:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170808161022.GO2081@work-vm>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-4-git-send-email-armbru@redhat.com>
	<20170808112016.GD2081@work-vm> <87k22e6phm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k22e6phm.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC PATCH 03/56] monitor: Rewrite comment
 describing HMP .args_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  monitor.c | 75 +++++++++++++++++++++++++++++++++++++++------------------------
> >>  1 file changed, 47 insertions(+), 28 deletions(-)
> >> 
> >> diff --git a/monitor.c b/monitor.c
> >> index e0f8801..8b54ba1 100644
> >> --- a/monitor.c
> >> +++ b/monitor.c
> >> @@ -85,37 +85,56 @@
> >>  #endif
> >>  
> >>  /*
> >> - * Supported types:
> >> + * Command handlers (mon_cmd_t member @cmd) receive actual arguments
> >> + * in a QDict, which is built by the HMP core according to mon_cmd_t
> >> + * member @args_type.  It's a list of NAME:TYPE separated by comma.
> >>   *
> >> - * 'F'          filename
> >> - * 'B'          block device name
> >> - * 's'          string (accept optional quote)
> >> - * 'S'          it just appends the rest of the string (accept optional quote)
> >> - * 'O'          option string of the form NAME=VALUE,...
> >> - *              parsed according to QemuOptsList given by its name
> >> - *              Example: 'device:O' uses qemu_device_opts.
> >> - *              Restriction: only lists with empty desc are supported
> >> - *              TODO lift the restriction
> >> - * 'i'          32 bit integer
> >> - * 'l'          target long (32 or 64 bit)
> >> - * 'M'          Non-negative target long (32 or 64 bit), in user mode the
> >> - *              value is multiplied by 2^20 (think Mebibyte)
> >> - * 'o'          octets (aka bytes)
> >> - *              user mode accepts an optional E, e, P, p, T, t, G, g, M, m,
> >> - *              K, k suffix, which multiplies the value by 2^60 for suffixes E
> >> - *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T and t,
> >> - *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K and k
> >> - * 'T'          double
> >> - *              user mode accepts an optional ms, us, ns suffix,
> >> - *              which divides the value by 1e3, 1e6, 1e9, respectively
> >> - * '/'          optional gdb-like print format (like "/10x")
> >> + * TYPEs that put a string value with key NAME into the QDict:
> >> + * 's'    Argument is enclosed in '"' or delimited by whitespace.  In
> >> + *        the former case, escapes \n \r \\ \' and \" are recognized.
> >> + * 'F'    File name, like 's' except for completion.
> >> + * 'B'    BlockBackend name, like 's' except for completion.
> >> + * 'S'    Argument is the remainder of the line, less leading
> >> + *        whitespace.
> >> +
> >>   *
> >> - * '?'          optional type (for all types, except '/')
> >> - * '.'          other form of optional type (for 'i' and 'l')
> >> - * 'b'          boolean
> >> - *              user mode accepts "on" or "off"
> >> - * '-'          optional parameter (eg. '-f')
> >> + * TYPEs that put an int64_t value with key NAME:
> >> + * 'l'    Argument is an expression (QEMU pocket calculator).
> >> + * 'i'    Like 'l' except value must fit into 32 bit unsigned.
> >> + * 'M'    Like 'l' except value must not be negative and is multiplied
> >> + *        by 2^20 (think "mebibyte").
> >>   *
> >> + * TYPEs that put an uint64_t value with key NAME:
> >> + * 'o'    Argument is a size (think "octets").  Without suffix the
> >> + *        value is multiplied by 2^20 (mebibytes), with suffix E or e
> >> + *        by 2^60 (exbibytes), with P or p by 2^50 (pebibytes), with T
> >> + *        or t by 2^40 (tebibytes), with G or g by 2^30 (gibibytes),
> >> + *        with M or m by 2^10 (mebibytes), with K or k by 2^10
> >> + *        (kibibytes).
> >
> > 'o' is messy.  It using qemu_strtosz_MiB which uses a 'double' intermediate
> > so I fear it can round.
> 
> It does, but only when you have more than 53 significant bits.
> 
> >                          It also has a note it can't take all f's due to
> > an overflow from the conversion.
> 
> Correct, because values between 0xfffffffffffffc00 and 2^64-1 round up
> to 2^64.

Right, so these bother me not for normal sizes, but if we were to start
to use them for hex values with meanings, like addresses for example.
(Although I guess that's unlikely with the default assumption of MB)

> If it bothers you, feel free to explore the following: feed the string
> both to strtod() and to strtoll().  Whichever eats more characters wins.

Is the reason we're using strtod because we actively want users to be
able to say 3.5G ?  I guess that's a reason to keep it.

> This patch is of course just about better documenting what we have.  I
> was starting to type something like "repeating the (complex) contract of
> qemu_strtosz_MiB() here isn't so hot, let's include it by reference
> instead", but then I looked it up.  Pffft.
> 
> >                                    Two things not mentioned are that
> > it also takes hex (as explicit 0x) and that it also does 'b' as a suffix
> > to multiply by 1.  Those two combine in bad ways - i.e. 0x1b is 27MB,
> > 1b is 1 byte (same for 'e').  These are probably OK except if you were
> > to start replacing 'l' by 'o' because you really wanted 64bit addresses
> > say.
> 
> I guess the sanest solution is not to recognize suffixes when the number
> is hexadecimal.
> 
> > (I also wouldn't bother expanding the size names and powers).
> 
> I erred on the side of tedious clarity.  Feel free to suggest something
> you like better.

I think something like:
  The optional suffix's b/k/m/g/t/p/e are accepted (upper or lower case)
  to denote bytes, kibibytes, mebibytes etc.  With no suffix, values
  are interpreted as MiB.

> >> + *
> >> + * TYPEs that put a double value with key NAME:
> >> + * 'T'    Argument is a time in seconds.  With optional ms, us, ns
> >> + *        suffix, the value divided by 1e3, 1e6, 1e9 respectively.
> >> + *
> >> + * TYPEs that put a bool value with key NAME:
> >> + * 'b'    Argument is either "on" (true) or "off" (false).
> >> + * '-' CHAR
> >> + *        Argument is either "-CHAR" (true) or absent (false).
> >
> > I found the previous description clearer.
> 
> What I don't like about the previous description: it defines by example.
> Examples are great, but they are for illustrating a definition, they
> can't really replace one.

I'm less fussy if it's clear; how about
   '-' CHAR
       True if optional single character argument (e.g. -f) is present
       else absent.

  since you've got the '-' CHAR   you have the definition.

> >> + * TYPEs that put multiple values:
> >> + * 'O'    Option string of the form NAME=VALUE,... parsed according to
> >> + *        the QemuOptsList given by its name.
> >> + *        Example: 'device:O' uses qemu_device_opts.
> >> + *        Restriction: only lists with empty desc are supported.
> >> + *        Puts all the NAME=VALUE.
> >> + * '/'    Gdb-like print format (like "/10x"), always optional.
> >> + *        Puts keys "count", "format", "size", all int.
> >> + *
> >> + * Modifier character following the type string:
> >> + * '?'    Argument is optional, nothing is put when it is absent
> >> + *        (all types except 'O', '/', 'b').
> >> + * '.'    Argument is optional, must be preceded by '.' if present
> >> + *        (only types 'i', 'l', 'M')
> >
> > That's obscure; I can only see one use of it in ioport_read and that's
> > extra-special!
> 
> Extra-special baroque!  Took me a while to figure out WTF it does :)

Should we avoid a lot of the 'o' pain by adding a new type; something
like:
  '6'
      A 64bit unsigned value.  Decimal or hex integers are accepted;
   optional suffixes of k/m/g/t/p/e are accepted to denote kibibytes
   etc.  With no suffix values are interpreted as bytes.

  then that would be suffix_mul() * qemu_strtou64()

Dave

> >>   */
> >>  
> >>  typedef struct mon_cmd_t {
> >> -- 
> >> 2.7.5
> 
> Thanks!
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
