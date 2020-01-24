Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF27C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569F220709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzgKH4H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569F220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3e1-0006BJ-Im
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv3dM-0005ee-J3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv3dK-0005kY-H0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:24:44 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv3dK-0005jc-6w
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:24:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id q9so379097wmj.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Y/au4VXu50q32kOV40zAEGeQiiDoPwdvl7dCBG7Lg+Q=;
 b=uzgKH4H47MvMG40FQzhIwW0AxhOiEHSEVrJUzOpV4U9V/jpamoD9KVttqUMWee9VM9
 1tLcSZVaibZuiVi1BHYEPgMrB7W7IdLL/cx1nq8fmYWVVY23kBK/SUAxS4l+VIavP4H/
 iRKIhbzdqYKNuQRSbKG+GR2wbWgJZsdxN90N/zKexBQ/1xWucWHQtWofEsLSsgR9oQIu
 fwZdMJXfTJRnbVPbPI2OHOY7Lqd9OX+i9u0ZO9ncABnI6abzZeAuOp4LhsZtSv3YQS9C
 oKxPxqu7Fs+vdzH/F3v+hLCMFIrVWWN3WGbRg++Gp1noe6KhmZdtDnvIU47jBtnNFUka
 LPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Y/au4VXu50q32kOV40zAEGeQiiDoPwdvl7dCBG7Lg+Q=;
 b=dJn8utsoelBBDDnneoxE8m5xfzVvD7XL0aqaPnBvfaISs2m1aAKNlyzZgGGCNp0Wbb
 0fX7EwT49hmSQY9PsS9PqWv+7TZPRwg86joTCHUNL0OT/xlR1pwyHSsrIS0w8aEuMYCK
 P1TB/ZK5Fxq0L2SO2gi8ejw/DEw1bibPrZm0p0uSVIZOWB3pjqmRpXgZzEVtpZ8N2EMi
 5l+jbrkgYschbubj6k0Qb+Oo9nUdLAPnVs6wEtTG1rggPIeFGFy2sm7W+ZwJT08Q9jhp
 1TpSuu7F1AMNuRf0K0dHvbfGwR/ywkzTBimLA0G1iHQ2/KjeLG6s7up4z13anozfy9qx
 y21A==
X-Gm-Message-State: APjAAAUQygv9MRuPv6csGd/gZtLXwlSQUrK8RH/XNrsXcFmo4L8MGnZg
 KcakV2R6zGdTmodxxXYKsTpsHg==
X-Google-Smtp-Source: APXvYqwrCswMj4qXsrtpofv217p3XRoS93a9+HWACIL7G4/5k+QIjbs2fqD/LSankqN5ZzAL3vtz+Q==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr409139wmp.19.1579890279257;
 Fri, 24 Jan 2020 10:24:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm8463646wrp.93.2020.01.24.10.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 10:24:38 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 80E7E1FF87;
 Fri, 24 Jan 2020 18:24:37 +0000 (GMT)
References: <20200124162606.8787-1-peter.maydell@linaro.org>
 <20200124162606.8787-4-peter.maydell@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 3/8] docs/sphinx: Add new hxtool Sphinx extension
In-reply-to: <20200124162606.8787-4-peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 18:24:37 +0000
Message-ID: <875zh0af16.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Some of our documentation includes sections which are created
> by assembling fragments of texinfo from a .hx source file into
> a .texi file, which is then included from qemu-doc.texi or
> qemu-img.texi.
>
> For Sphinx, rather than creating a file to include, the most natural
> way to handle this is to have a small custom Sphinx extension which
> reads the .hx file and process it.  So instead of:
>  * makefile produces foo.texi from foo.hx
>  * qemu-doc.texi says '@include foo.texi'
> we have:
>  * qemu-doc.rst says 'hxtool-doc:: foo.hx'
>  * the Sphinx extension for hxtool has code that runs to handle that
>    Sphinx directive which reads the .hx file and emits the appropriate
>    documentation contents
>
> This is pretty much the same way the kerneldoc extension works right
> now. It also has the advantage that it should work for third-party
> services like readthedocs that expect to build the docs directly with
> sphinx rather than by invoking our makefiles.
>
> In this commit we implement the hxtool extension.
>
> Note that syntax errors in the rST fragments will be correctly
> reported to the user with the filename and line number within the
> hx file.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/conf.py          |   3 +-
>  docs/sphinx/hxtool.py | 210 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 docs/sphinx/hxtool.py
>
> diff --git a/docs/conf.py b/docs/conf.py
> index 259c6049da7..ee7faa6b4e7 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -54,7 +54,7 @@ needs_sphinx =3D '1.3'
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>  # ones.
> -extensions =3D ['kerneldoc', 'qmp_lexer']
> +extensions =3D ['kerneldoc', 'qmp_lexer', 'hxtool']
>=20=20
>  # Add any paths that contain templates here, relative to this directory.
>  templates_path =3D ['_templates']
> @@ -221,3 +221,4 @@ texinfo_documents =3D [
>  # find everything.
>  kerneldoc_bin =3D os.path.join(qemu_docdir, '../scripts/kernel-doc')
>  kerneldoc_srctree =3D os.path.join(qemu_docdir, '..')
> +hxtool_srctree =3D os.path.join(qemu_docdir, '..')
> diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
> new file mode 100644
> index 00000000000..5d6736f3002
> --- /dev/null
> +++ b/docs/sphinx/hxtool.py
> @@ -0,0 +1,210 @@
> +# coding=3Dutf-8
> +#
> +# QEMU hxtool .hx file parsing extension
> +#
> +# Copyright (c) 2020 Linaro
> +#
> +# This work is licensed under the terms of the GNU GPLv2 or later.
> +# See the COPYING file in the top-level directory.
> +"""hxtool is a Sphinx extension that implements the hxtool-doc directive=
"""
> +
> +# The purpose of this extension is to read fragments of rST
> +# from .hx files, and insert them all into the current document.
> +# The rST fragments are delimited by SRST/ERST lines.
> +# The conf.py file must set the hxtool_srctree config value to
> +# the root of the QEMU source tree.
> +# Each hxtool-doc:: directive takes one argument which is the
> +# path of the .hx file to process, relative to the source tree.
> +
> +import os
> +import re
> +from enum import Enum
> +
> +from docutils import nodes
> +from docutils.statemachine import ViewList
> +from docutils.parsers.rst import directives, Directive
> +from sphinx.errors import ExtensionError
> +from sphinx.util.nodes import nested_parse_with_titles
> +import sphinx
> +
> +# Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
> +# use switch_source_input. Check borrowed from kerneldoc.py.
> +Use_SSI =3D sphinx.__version__[:3] >=3D '1.7'
> +if Use_SSI:
> +    from sphinx.util.docutils import switch_source_input
> +else:
> +    from sphinx.ext.autodoc import AutodocReporter
> +
> +__version__ =3D '1.0'
> +
> +# We parse hx files with a state machine which may be in one of three
> +# states: reading the C code fragment, inside a texi fragment,
> +# or inside a rST fragment.
> +class HxState(Enum):
> +    CTEXT =3D 1
> +    TEXI =3D 2
> +    RST =3D 3
> +
> +def serror(file, lnum, errtext):
> +    """Raise an exception giving a user-friendly syntax error message"""
> +    raise ExtensionError('%s line %d: syntax error: %s' % (file, lnum, e=
rrtext))
> +
> +def parse_directive(line):
> +    """Return first word of line, if any"""
> +    return re.split('\W', line)[0]
> +
> +def parse_defheading(file, lnum, line):
> +    """Handle a DEFHEADING directive"""
> +    # The input should be "DEFHEADING(some string)", though note that
> +    # the 'some string' could be the empty string. If the string is
> +    # empty we ignore the directive -- these are used only to add
> +    # blank lines in the plain-text content of the --help output.
> +    #
> +    # Return the heading text
> +    match =3D re.match(r'DEFHEADING\((.*)\)', line)
> +    if match is None:
> +        serror(file, lnum, "Invalid DEFHEADING line")
> +    return match.group(1)
> +
> +def parse_archheading(file, lnum, line):
> +    """Handle an ARCHHEADING directive"""
> +    # The input should be "ARCHHEADING(some string, other arg)",
> +    # though note that the 'some string' could be the empty string.
> +    # As with DEFHEADING, empty string ARCHHEADINGs will be ignored.
> +    #
> +    # Return the heading text
> +    match =3D re.match(r'ARCHHEADING\((.*),.*\)', line)
> +    if match is None:
> +        serror(file, lnum, "Invalid ARCHHEADING line")
> +    return match.group(1)
> +
> +class HxtoolDocDirective(Directive):
> +    """Extract rST fragments from the specified .hx file"""
> +    required_argument =3D 1
> +    optional_arguments =3D 1
> +    option_spec =3D {
> +        'hxfile': directives.unchanged_required
> +    }
> +    has_content =3D False
> +
> +    def run(self):
> +        env =3D self.state.document.settings.env
> +        hxfile =3D env.config.hxtool_srctree + '/' + self.arguments[0]
> +
> +        # Tell sphinx of the dependency
> +        env.note_dependency(os.path.abspath(hxfile))
> +
> +        state =3D HxState.CTEXT
> +        # We build up lines of rST in this ViewList, which we will
> +        # later put into a 'section' node.
> +        rstlist =3D ViewList()
> +        current_node =3D None
> +        node_list =3D []
> +
> +        with open(hxfile) as f:
> +            lines =3D (l.rstrip() for l in f)
> +            for lnum, line in enumerate(lines, 1):
> +                directive =3D parse_directive(line)
> +
> +                if directive =3D=3D 'HXCOMM':
> +                    pass
> +                elif directive =3D=3D 'STEXI':
> +                    if state =3D=3D HxState.RST:
> +                        serror(hxfile, lnum, 'expected ERST, found STEXI=
')
> +                    elif state =3D=3D HxState.TEXI:
> +                        serror(hxfile, lnum, 'expected ETEXI, found STEX=
I')
> +                    else:
> +                        state =3D HxState.TEXI
> +                elif directive =3D=3D 'ETEXI':
> +                    if state =3D=3D HxState.RST:
> +                        serror(hxfile, lnum, 'expected ERST, found ETEXI=
')
> +                    elif state =3D=3D HxState.CTEXT:
> +                        serror(hxfile, lnum, 'expected STEXI, found ETEX=
I')
> +                    else:
> +                        state =3D HxState.CTEXT
> +                elif directive =3D=3D 'SRST':
> +                    if state =3D=3D HxState.RST:
> +                        serror(hxfile, lnum, 'expected ERST, found SRST')
> +                    elif state =3D=3D HxState.TEXI:
> +                        serror(hxfile, lnum, 'expected ETEXI, found SRST=
')
> +                    else:
> +                        state =3D HxState.RST
> +                elif directive =3D=3D 'ERST':
> +                    if state =3D=3D HxState.TEXI:
> +                        serror(hxfile, lnum, 'expected ETEXI, found ERST=
')
> +                    elif state =3D=3D HxState.CTEXT:
> +                        serror(hxfile, lnum, 'expected SRST, found ERST')
> +                    else:
> +                        state =3D HxState.CTEXT
> +                elif directive =3D=3D 'DEFHEADING' or directive =3D=3D '=
ARCHHEADING':
> +                    if directive =3D=3D 'DEFHEADING':
> +                        heading =3D parse_defheading(hxfile, lnum, line)
> +                    else:
> +                        heading =3D parse_archheading(hxfile, lnum, line)
> +                    if heading =3D=3D "":
> +                        continue
> +                    # Put the accumulated rST into the previous node,
> +                    # and then start a fresh section with this heading.
> +                    if len(rstlist) > 0:
> +                        if current_node is None:
> +                            # We had some rST fragments before the first
> +                            # DEFHEADING. We don't have a section to put
> +                            # these in, so rather than magicing up a sec=
tion,
> +                            # make it a syntax error.
> +                            serror(hxfile, lnum,
> +                                   'first DEFHEADING must precede all rS=
T text')
> +                        self.do_parse(rstlist, current_node)
> +                        rstlist =3D ViewList()
> +                    if current_node is not None:
> +                        node_list.append(current_node)
> +                    section_id =3D 'hxtool-%d' % env.new_serialno('hxtoo=
l')
> +                    current_node =3D nodes.section(ids=3D[section_id])
> +                    current_node +=3D nodes.title(heading, heading)
> +                else:
> +                    # Not a directive: put in output if we are in rST fr=
agment
> +                    if state =3D=3D HxState.RST:
> +                        # Sphinx counts its lines from 0
> +                        rstlist.append(line, hxfile, lnum - 1)
> +
> +        if current_node is None:
> +            # We don't have multiple sections, so just parse the rst
> +            # fragments into a dummy node so we can return the children.
> +            current_node =3D nodes.section()
> +            self.do_parse(rstlist, current_node)
> +            return current_node.children
> +        else:
> +            # Put the remaining accumulated rST into the last section, a=
nd
> +            # return all the sections.
> +            if len(rstlist) > 0:
> +                self.do_parse(rstlist, current_node)
> +            node_list.append(current_node)
> +            return node_list
> +
> +    # This is from kerneldoc.py -- it works around an API change in
> +    # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
> +    # sphinx.util.nodes.nested_parse_with_titles() rather than the
> +    # plain self.state.nested_parse(), and so we can drop the saving
> +    # of title_styles and section_level that kerneldoc.py does,
> +    # because nested_parse_with_titles() does that for us.
> +    def do_parse(self, result, node):
> +        if Use_SSI:
> +            with switch_source_input(self.state, result):
> +                nested_parse_with_titles(self.state, result, node)
> +        else:
> +            save =3D self.state.memo.reporter
> +            self.state.memo.reporter =3D AutodocReporter(result, self.st=
ate.memo.reporter)
> +            try:
> +                nested_parse_with_titles(self.state, result, node)
> +            finally:
> +                self.state.memo.reporter =3D save
> +
> +def setup(app):
> +    """ Register hxtool-doc directive with Sphinx"""
> +    app.add_config_value('hxtool_srctree', None, 'env')
> +    app.add_directive('hxtool-doc', HxtoolDocDirective)
> +
> +    return dict(
> +        version =3D __version__,
> +        parallel_read_safe =3D True,
> +        parallel_write_safe =3D True
> +    )


--=20
Alex Benn=C3=A9e

