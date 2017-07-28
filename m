Received: from eggs.gnu.org ([2001:4830:134:3::10]:44268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db9lt-00089t-BH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db9lo-00026l-4H
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1db9ln-000269-R0
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:13:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6D087ACB5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 18:13:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-2-eblake@redhat.com>
Date: Fri, 28 Jul 2017 20:13:46 +0200
In-Reply-To: <20170725211523.3998-2-eblake@redhat.com> (Eric Blake's message
	of "Tue, 25 Jul 2017 16:15:12 -0500")
Message-ID: <877eysl99h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 01/12] qobject: Accept "%"PRId64 in
 qobject_from_jsonf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

Eric Blake <eblake@redhat.com> writes:

> Commit 1792d7d0 was written because PRId64 expands to non-portable
> crap for some libc, and we had testsuite failures on Mac OS as a
> result.  This in turn makes it difficult to rely on the obvious
> conversions of 64-bit values into JSON, requiring things such as
> casting int64_t to long long so we can use a reliable %lld and
> still keep -Wformat happy.  So now it's time to fix that.
>
> We are already lexing %I64d (hello mingw); now expand the lexer
> to parse %qd (hello Mac OS). In the process, we can drop one
> state: IN_ESCAPE_I64 is redundant with IN_ESCAPE_LL, and reused
> again by %qd, so rename it to IN_ESCAPE_64.  And fix a comment
> that mistakenly omitted %u as a supported escape.
>
> Next, tweak the parser to accept the exact spelling of PRId64
> regardless of what it expands to (note that there are are now dead
> branches in the 'if' chain for some platforms, like glibc; but
> there are other platforms where all branches are necessary).  We
> are at least safe in that we are parsing the correct size 32-bit or
> a 64-bit quantity on whatever branch we end up in.  This also means
> that we no longer parse everything that the lexer will consume (no
> more %I64d on glibc), but that is intentional.  And of course,
> update the testsuite for coverage of the feature.
>
> Finally, update configure to barf on any libc that uses yet
> another form of PRId64 that we have not yet coded for, so that we
> can once again update json-lexer.c to cater to those quirks (my
> guess? we might see %jd next) (on the bright side, json-parser.c
> should no longer need updates).  Yes, the only way I could find
> to quickly learn what spelling is preferred when cross-compiling
> is to grep a compiled binary; C does not make it easy to turn a
> string constant into an integer constant, let alone make
> preprocessor decisions; and even parsing '$CC -E' output is
> fragile, since 64-bit glibc pre-processes as "l" "d" rather than
> "ld", and newer gcc splits macro expansions across multiple lines.
> I'm assuming that 'strings' is portable enough during configure;
> if that assumption fails in some constrained docker environment,
> an easy hack is to add this to configure:
>   strings () { tr -d '\0' < "$1"; }
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v3: incorporate review comments from Markus
> ---
>  configure             | 24 ++++++++++++++++++++++++
>  qobject/json-lexer.c  | 21 +++++++++------------
>  qobject/json-parser.c | 10 ++++++----
>  tests/check-qjson.c   |  7 +++++++
>  4 files changed, 46 insertions(+), 16 deletions(-)
>
> diff --git a/configure b/configure
> index 987f59ba88..5b0eddec3c 100755
> --- a/configure
> +++ b/configure
> @@ -3222,6 +3222,30 @@ for i in $glib_modules; do
>      fi
>  done
>
> +# Sanity check that we can parse PRId64 and friends in json-lexer.c
> +# (Sadly, the "easiest" way to do this is to grep the compiled binary,
> +# since we can't control whether the preprocessor would output "ld" vs.
> +# "l" "d", nor even portably ensure it fits output on the same line as
> +# a witness marker.)
> +cat > $TMPC <<EOF
> +#include <inttypes.h>
> +int main(void) {
> +    static const char findme[] = "\nUnLiKeLyToClAsH_" PRId64 "\n";
> +    return !findme[0];
> +}
> +EOF
> +if ! compile_prog "$CFLAGS" "$LIBS" ; then

Would compile_object suffice?

> +    error_exit "can't determine value of PRId64"
> +fi
> +nl='
> +'
> +case $(strings $TMPE | grep ^UnLiKeLyToClAsH) in
> +    '' | *"$nl"* ) error_exit "can't determine value of PRId64" ;;
> +    *_ld | *_lld | *_I64d | *_qd) ;;
> +    *) error_exit "unexepected value of PRId64, please add %$(strings $TMPE |
> +       sed -n s/^UnLiKeLyToClAsH_//p) support to json-lexer.c" ;;
> +esac
> +
>  # Sanity check that the current size_t matches the
>  # size that glib thinks it should be. This catches
>  # problems on multi-arch where people try to build
> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> index 980ba159d6..9a0fc58444 100644
> --- a/qobject/json-lexer.c
> +++ b/qobject/json-lexer.c
> @@ -29,9 +29,11 @@
>   *
>   * '([^\\']|\\[\"'\\/bfnrt]|\\u[0-9a-fA-F]{4})*'
>   *
> - * Extension for vararg handling in JSON construction:
> + * Extension for vararg handling in JSON construction [this lexer
> + * actually accepts multiple forms of PRId64, but parse_escape() later
> + * filters to only parse the current platform's spelling]:

I'd stick to (parenthesis) instead of [square brackets] here.

>   *
> - * %((l|ll|I64)?d|[ipsf])
> + * %(PRI[du]64|(l|ll)?[ud]|[ipsf])
>   *
>   */
>
[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>
