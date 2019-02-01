Received: from eggs.gnu.org ([209.51.188.92]:47908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcKe-0001Wg-HD
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpc8j-0001gC-8q
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:58:06 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpc8j-0001eX-04
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:58:05 -0500
Received: by mail-wm1-x341.google.com with SMTP id m1so6836024wml.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:58:04 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-9-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201145035.22739-9-peter.maydell@linaro.org>
Date: Fri, 01 Feb 2019 16:58:01 +0000
Message-ID: <87ef8rv42u.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/11] Separate conf.py for each manual we
 want
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> ---
>  docs/conf.py           | 37 +++++++++++++++++++++++++++++++------
>  docs/devel/conf.py     | 15 +++++++++++++++
>  docs/devel/index.rst   | 21 +++++++++++++++++++++
>  docs/index.rst         |  9 ++-------
>  docs/interop/conf.py   | 15 +++++++++++++++
>  docs/interop/index.rst | 18 ++++++++++++++++++
>  6 files changed, 102 insertions(+), 13 deletions(-)
>  create mode 100644 docs/devel/conf.py
>  create mode 100644 docs/devel/index.rst
>  create mode 100644 docs/interop/conf.py
>  create mode 100644 docs/interop/index.rst

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> diff --git a/docs/conf.py b/docs/conf.py
> index c04000e78e4..6a334f545ec 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -3,6 +3,20 @@
>  # QEMU documentation build configuration file, created by
>  # sphinx-quickstart on Thu Jan 31 16:40:14 2019.
>  #
> +# This config file can be used in one of two ways:
> +# (1) as a common config file which is included by the conf.py
> +# for each of QEMU's manuals: in this case sphinx-build is run multiple
> +# times, once per subdirectory.
> +# (2) as a top level conf file which will result in building all
> +# the manuals into a single document: in this case sphinx-build is
> +# run once, on the top-level docs directory.
> +#
> +# QEMU's makefiles take option (1), which allows us to install
> +# only the ones the user cares about (in particular we don't want
> +# to ship the 'devel' manual to end-users).
> +# Third-party sites such as readthedocs.org will take option (2).
> +#
> +#
>  # This file is execfile()d with the current directory set to its
>  # containing dir.
>  #
> @@ -12,13 +26,22 @@
>  # All configuration values have a default; values that are commented out
>  # serve to show the default.
>
> +import os
> +import sys
> +
> +# The per-manual conf.py will set qemu_docdir for a single-manual build;
> +# otherwise set it here if this is an entire-manual-set build.
> +# This is always the absolute path of the docs/ directory in the source =
tree.
> +try:
> +    qemu_docdir
> +except NameError:
> +    qemu_docdir =3D os.path.abspath(".")
> +
>  # If extensions (or modules to document with autodoc) are in another dir=
ectory,
>  # add these directories to sys.path here. If the directory is relative t=
o the
> -# documentation root, use os.path.abspath to make it absolute, like show=
n here.
> +# documentation root, use an absolute path starting from qemu_docdir.
>  #
> -# import os
> -# import sys
> -# sys.path.insert(0, os.path.abspath('.'))
> +# sys.path.insert(0, os.path.join(qemu_docdir, "my_subdir"))
>
>
>  # -- General configuration ---------------------------------------------=
---
> @@ -90,8 +113,10 @@ html_theme =3D 'alabaster'
>  # Theme options are theme-specific and customize the look and feel of a =
theme
>  # further.  For a list of options available for each theme, see the
>  # documentation.
> -#
> -# html_theme_options =3D {}
> +# We initialize this to empty here, so the per-manual conf.py can just
> +# add individual key/value entries.
> +html_theme_options =3D {
> +}
>
>  # Add any paths that contain custom static files (such as style sheets) =
here,
>  # relative to this directory. They are copied after the builtin static f=
iles,
> diff --git a/docs/devel/conf.py b/docs/devel/conf.py
> new file mode 100644
> index 00000000000..7441f87e7f5
> --- /dev/null
> +++ b/docs/devel/conf.py
> @@ -0,0 +1,15 @@
> +# -*- coding: utf-8 -*-
> +#
> +# QEMU documentation build configuration file for the 'devel' manual.
> +#
> +# This includes the top level conf file and then makes any necessary twe=
aks.
> +import sys
> +import os
> +
> +qemu_docdir =3D os.path.abspath("..")
> +parent_config =3D os.path.join(qemu_docdir, "conf.py")
> +exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
> +
> +# This slightly misuses the 'description', but is the best way to get
> +# the manual title to appear in the sidebar.
> +html_theme_options['description'] =3D u'Developer''s Guide'
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> new file mode 100644
> index 00000000000..cd0fa6c9ba2
> --- /dev/null
> +++ b/docs/devel/index.rst
> @@ -0,0 +1,21 @@
> +.. This is the top level page for the 'devel' manual.
> +
> +
> +QEMU Developer's Guide
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This manual documents various parts of the internals of QEMU.
> +You only need to read it if you are interested in reading or
> +modifying QEMU's source code.
> +
> +Contents:
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   loads-stores
> +   memory
> +   migration
> +   stable-process
> +   testing
> +
> diff --git a/docs/index.rst b/docs/index.rst
> index 93f82228310..3690955dd1f 100644
> --- a/docs/index.rst
> +++ b/docs/index.rst
> @@ -10,11 +10,6 @@ Welcome to QEMU's documentation!
>     :maxdepth: 2
>     :caption: Contents:
>
> +   interop/index
> +   devel/index
>
> -
> -Indices and tables
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -* :ref:`genindex`
> -* :ref:`modindex`
> -* :ref:`search`
> diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> new file mode 100644
> index 00000000000..cf3c69d4a7e
> --- /dev/null
> +++ b/docs/interop/conf.py
> @@ -0,0 +1,15 @@
> +# -*- coding: utf-8 -*-
> +#
> +# QEMU documentation build configuration file for the 'interop' manual.
> +#
> +# This includes the top level conf file and then makes any necessary twe=
aks.
> +import sys
> +import os
> +
> +qemu_docdir =3D os.path.abspath("..")
> +parent_config =3D os.path.join(qemu_docdir, "conf.py")
> +exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
> +
> +# This slightly misuses the 'description', but is the best way to get
> +# the manual title to appear in the sidebar.
> +html_theme_options['description'] =3D u'System Emulation Management and =
Interoperability Guide'
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> new file mode 100644
> index 00000000000..2df977dd529
> --- /dev/null
> +++ b/docs/interop/index.rst
> @@ -0,0 +1,18 @@
> +.. This is the top level page for the 'interop' manual.
> +
> +
> +QEMU System Emulation Management and Interoperability Guide
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This manual contains documents and specifications that are useful
> +for making QEMU interoperate with other software.
> +
> +Contents:
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   bitmaps
> +   live-block-operations
> +   pr-helper
> +


--
Alex Benn=C3=A9e
