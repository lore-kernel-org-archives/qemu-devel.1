Received: from eggs.gnu.org ([2001:4830:134:3::10]:42250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fE9Q6-0000C0-7c
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fE9Q4-0003QY-Mp
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:16:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
Date: Thu, 03 May 2018 10:16:44 +0200
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com> (Max Reitz's message of
	"Wed, 2 May 2018 23:32:12 +0200")
Message-ID: <871setrw5v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 0/7] block: Try to use correctly typed
 blockdev options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Max Reitz <mreitz@redhat.com> writes:

> (Sorry, Markus, sorry, Kevin, if this series makes you angry.)

Anger?  Nah.  Gallows humor :)

> The subject says it all, I think.  The original issue I was assigned to
> solve is this:
>
>     $ ./qemu-img info --image-opts driver=null-co,size=42
>     image: json:{"driver": "null-co", "size": "42"}
>     [...]
>
> As you can see, "size" gets a string value in the json:{} object
> although it is an integer, according to the QAPI schema.  (Buglink:
> https://bugzilla.redhat.com/show_bug.cgi?id=1534396)
>
> My first approach to fix this was to try to pipe the full_open_options
> dict generated in bdrv_refresh_filename() through a keyval input visitor
> and then an output visitor (which would have depended on my filename
> series).  This did not work out because bs->options (where all of the
> reconstructed options come from) may either be correctly typed or not,
> and keyval chokes on non-string values.  I could have probably converted
> bs->options to fully string values before trying to pipe it through
> keyval, but I decided I didn't like that very much.  (I suppose I can be
> convinced otherwise, though.)

See also thread

    [RFC][BROKEN] rbd: Allow configuration of authentication scheme"
    Message-Id: <20180405170619.20480-1-kwolf@redhat.com>
    https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00618.html

in particular the qdict_stringify_entries() proposal and its discussion.

> So I decided to venture into the territory of what we actually want at
> some point: Correctly typed bs->options.  Or, rather, in the end we want
> bs->options to be BlockdevOptions, but let's not be too hasty here.
>
> So it turns out that with really just a bit of work we can separate the
> interfaces that generate correctly typed options (e.g. blockdev-add)
> from the ones that generate pure string-valued options (e.g. qemu-img
> --image-opts) rather well.  Once we have done that, we can pipe all of
> the pure string options through keyval and back to get correctly typed
> options.
>
> So far the theory.  Now, in practice we of course have pitfalls, and
> those are not addressed by this series, which is the main reason this is
> an RFC.
>
> The first pitfall (I can see...) is that json:{} allows you to specify
> mixed options -- some values are incorrectly strings, others are
> non-strings.  keyval cannot cope with that, so the result after this
> series is that those options end up in bs->options just like that.  I
> suppose we could just forbid that mixed-typed case, though, and call it
> a bug fix.

Related: QMP device_add and netdev_add convert their arguments from
QDict to QemuOpts with qemu_opts_from_qdict(), and therefore accept
string in addition to number / bool.  If I remember correctly, Eric
Blake's patches to QAPIfy netdev_add got stuck because they didn't
replicate that behavior.

I think we should reject inappropriate strings.  If we think nobody's
relying on it, we can call it a bug and just fix it.  If we don't dare,
we need to go through the deprecation ritual.  We should've done that
long ago, but better now than never.

Same for json:{}.

> The second problem (and I think the big reason why we have not
> approached this issue so far) is that there are options which you can
> give as strings, but which are not covered by the schema.  In such a
> case, the input visitor will reject the QDict and we will just use it
> as-is, that is, full of strings.  Now that is not what we want in the
> end, of course -- we want everything to be converted into something that
> is covered by the schema.

Can you give an example?

> My reasoning for sending this series anyway is that it doesn't make
> things worse (bs->options is a mess already, you can never be certain
> that it contains correctly typed values or just strings or both), and
> that it at least gives a starting point from which we can continue on.
> After this series, we have a clear separation between the interfaces
> that use purely string values and the ones that provide correct typing
> (well, and json:{}).
>
> Oh, and it fixes the above BZ for the more common cases.

"for the more common cases", ha!
