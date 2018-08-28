Received: from eggs.gnu.org ([2001:4830:134:3::10]:41181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fud5Y-0001WC-P9
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fud5U-0007DV-Kh
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:27:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fud5U-0007Cc-DK
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:27:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180827213943.33524-1-eblake@redhat.com>
	<20180827213943.33524-3-eblake@redhat.com>
Date: Tue, 28 Aug 2018 14:27:10 +0200
In-Reply-To: <20180827213943.33524-3-eblake@redhat.com> (Eric Blake's message
	of "Mon, 27 Aug 2018 16:39:43 -0500")
Message-ID: <87k1oaoew1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: Add comments to aid debugging
 generated introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> We consciously chose in commit 1a9a507b to hide QAPI type names
> from the introspection output on the wire, but added a command
> line option -u to unmask the type name when doing a debug build.
> The unmask option still remains useful to some other forms of
> automated analysis, so it will not be removed; however, when it
> is not in use, the generated .c file can be hard to read.  At
> the time when we first introduced masking, the generated file
> consisted only of a monolithic C string, so there was no clean
> way to inject any comments.
>
> Later, in commit 7d0f982b, we switched the generation to output
> a QLit object, in part to make it easier for future addition of
> conditional compilation.  In fact, commit d626b6c1 took advantage
> of this by passing a tuple instead of a bare object for encoding
> the output of conditionals.  By extending that tuple, we can now
> interject strategic comments.
>
> For now, type name debug aid comments are only output once per
> meta-type, rather than at all uses of the number used to encode
> the type within the introspection data.  But this is still a lot
> more convenient than having to regenerate the file with the
> unmask operation temporarily turned on - merely search the
> generated file for '"NNN" =' to learn the corresponding source
> name and associated definition of type NNN.
>
> The generated qapi-introspect.c changes only with the addition
> of comments, such as:
>
> | @@ -14755,6 +15240,7 @@
> |          { "name", QLIT_QSTR("[485]"), },
> |          {}
> |      })),
> | +    /* "485" = QCryptoBlockInfoLUKSSlot */
> |      QLIT_QDICT(((QLitDictEntry[]) {
> |          { "members", QLIT_QLIST(((QLitObject[]) {
> |              QLIT_QDICT(((QLitDictEntry[]) {
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v2: rebase on conditional code additions, drop patch to remove -u,
> update documentation to match
> ---
>  docs/devel/qapi-code-gen.txt |  1 +
>  scripts/qapi/introspect.py   | 27 +++++++++++++++++++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index c2e11465f0f..9d5b1409e72 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1412,6 +1412,7 @@ Example:
>              { "name", QLIT_QSTR("Event") },
>              { }
>          })),
> +        /* "0" = q_empty */
>          QLIT_QDICT(((QLitDictEntry[]) {
>              { "members", QLIT_QLIST(((QLitObject[]) {
>                  { }

Let's rebase onto my "[PATCH 0/2] qapi: A whitespace touch-up, and a doc
update".  The appended fixup needs to be squashed in then.  Happy to do
that in my tree.

> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 43e81a06938..67d6106f77b 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -19,12 +19,17 @@ def to_qlit(obj, level=0, suppress_first_indent=False):
>          return level * 4 * ' '
>
>      if isinstance(obj, tuple):
> -        ifobj, ifcond = obj
> -        ret = gen_if(ifcond)
> +        ifobj, extra = obj
> +        ifcond = extra.get('if')
> +        comment = extra.get('comment')
> +        ret = ''
> +        if comment:
> +            ret += indent(level) + '/* %s */\n' % comment
> +        if ifcond:
> +            ret += gen_if(ifcond)
>          ret += to_qlit(ifobj, level)
> -        endif = gen_endif(ifcond)
> -        if endif:
> -            ret += '\n' + endif
> +        if ifcond:
> +            ret += '\n' + gen_endif(ifcond)
>          return ret
>
>      ret = ''
> @@ -137,11 +142,21 @@ const QLitObject %(c_name)s = %(c_string)s;
>          return self._name(typ.name)
>
>      def _gen_qlit(self, name, mtype, obj, ifcond):
> +        extra = {}
>          if mtype not in ('command', 'event', 'builtin', 'array'):
> +            if not self._unmask:
> +                # Output a comment to make it easy to map masked names
> +                # back to the source when reading the generated output.
> +                extra['comment'] = '"%s" = %s' % (self._name(name), name)
>              name = self._name(name)
>          obj['name'] = name
>          obj['meta-type'] = mtype
> -        self._qlits.append((obj, ifcond))
> +        if ifcond:
> +            extra['if'] = ifcond
> +        if extra:
> +            self._qlits.append((obj, extra))
> +        else:
> +            self._qlits.append(obj)
>
>      def _gen_member(self, member):
>          ret = {'name': member.name, 'type': self._use_type(member.type)}

Reviewed-by: Markus Armbruster <armbru@redhat.com>


diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index a4091a7d78..f9990808de 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1430,7 +1430,7 @@ Example:
             { "name", QLIT_QSTR("MY_EVENT"), },
             {}
         })),
-        /* "0" = q_empty */
+        /* "0" = q_obj_my-command-arg */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "members", QLIT_QLIST(((QLitObject[]) {
                 QLIT_QDICT(((QLitDictEntry[]) {
@@ -1444,6 +1444,7 @@ Example:
             { "name", QLIT_QSTR("0"), },
             {}
         })),
+        /* "1" = UserDefOne */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "members", QLIT_QLIST(((QLitObject[]) {
                 QLIT_QDICT(((QLitDictEntry[]) {
@@ -1463,6 +1464,7 @@ Example:
             { "name", QLIT_QSTR("1"), },
             {}
         })),
+        /* "2" = q_empty */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "members", QLIT_QLIST(((QLitObject[]) {
                 {}
