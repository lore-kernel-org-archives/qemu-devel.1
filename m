Received: from eggs.gnu.org ([2001:4830:134:3::10]:41058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df5mg-0006cU-Uh
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df5mf-0000Na-J0
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:47:02 -0400
Date: Tue, 8 Aug 2017 15:46:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170808144638.GA2716@work-vm>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-4-git-send-email-armbru@redhat.com>
	<20170808112016.GD2081@work-vm>
	<94d733e5-cd55-99ef-403f-247aa68619f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d733e5-cd55-99ef-403f-247aa68619f1@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 08/08/2017 13:20, Dr. David Alan Gilbert wrote:
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
> > so I fear it can round.  It also has a note it can't take all f's due to
> > an overflow from the conversion.   Two things not mentioned are that
> > it also takes hex (as explicit 0x) and that it also does 'b' as a suffix
> > to multiply by 1.  Those two combine in bad ways - i.e. 0x1b is 27MB,
> > 1b is 1 byte (same for 'e').  These are probably OK except if you were
> > to start replacing 'l' by 'o' because you really wanted 64bit addresses
> > say.
> > (I also wouldn't bother expanding the size names and powers).
> > 
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
> > 
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
> It seems like the idea is that
> 
>     ioport_read 0x70.0xc
> 
> is expanded to
> 
>     write 0xc to 0x70
>     read from 0x71

Yes, and I have done that manually in the past with o/b and i.

> I can see how it can be useful for both RTC and VGA I/O ports, but on
> the other hand ioport_write doesn't support it and as you said it's
> really obscure.  I guess it can be removed or changed to not use "?",
> though it's such a nice little nugget. :)

Arguably this sugar is safer than doing it as two separate o/b and i
commands because with the lock held nothing can sneak in between the
two and change the selected port.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
