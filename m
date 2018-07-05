Received: from eggs.gnu.org ([2001:4830:134:3::10]:39398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faxLW-0008B6-DD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faxLT-0005Qw-BM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:02:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faxLT-0005Q2-4X
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:02:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F6054023132
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 06:02:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-3-peterx@redhat.com>
Date: Thu, 05 Jul 2018 08:02:21 +0200
In-Reply-To: <20180704084507.14560-3-peterx@redhat.com> (Peter Xu's message of
	"Wed, 4 Jul 2018 16:45:00 +0800")
Message-ID: <87601ucj9u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/9] qapi: allow build_params to return
 "void"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> When there is no parameter at all for a function prototype, return
> "void" for the parameter list.  This will happen after the next patch
> where we removed the Error* for some of the emit functions.

Error **, actually.  Let's say

  qapi: Fix build_params() for empty parameter list

  build_params() returns '' instead of 'void' when there are no
  parameters.  Can't happen now, but the next commit will change that.

>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  scripts/qapi/common.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 8b6708dbf1..105c82742f 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1963,7 +1963,7 @@ extern const QEnumLookup %(c_name)s_lookup;
>  def build_params(arg_type, boxed, extra):
>      if not arg_type:
>          assert not boxed
> -        return extra
> +        return extra if extra else "void"
>      ret = ''
>      sep = ''
>      if boxed:
> @@ -1980,7 +1980,7 @@ def build_params(arg_type, boxed, extra):
>                                c_name(memb.name))
>      if extra:
>          ret += sep + extra
> -    return ret
> +    return ret if ret else "void"
>  
>  
>  #

Please use ' instead of " for local consistency.

Duplicating "if ret else 'void'" minimizes churn, but it's slightly
ugly.  I append my attempt to avoid it.  What do you think?


diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 8b6708dbf1..01384c5360 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1961,15 +1961,13 @@ extern const QEnumLookup %(c_name)s_lookup;
 
 
 def build_params(arg_type, boxed, extra):
-    if not arg_type:
-        assert not boxed
-        return extra
     ret = ''
     sep = ''
     if boxed:
+        assert arg_type
         ret += '%s arg' % arg_type.c_param_type()
         sep = ', '
-    else:
+    elif arg_type:
         assert not arg_type.variants
         for memb in arg_type.members:
             ret += sep
@@ -1980,7 +1978,7 @@ def build_params(arg_type, boxed, extra):
                               c_name(memb.name))
     if extra:
         ret += sep + extra
-    return ret
+    return ret if ret else 'void'
 
 
 #
