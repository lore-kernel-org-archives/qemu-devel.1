Received: from eggs.gnu.org ([209.51.188.92]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtU9U-00040P-TP
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtU3C-0000Wa-Lw
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:08:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtU39-0000LU-QA
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:08:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190211163829.10297-1-pbonzini@redhat.com>
Date: Tue, 12 Feb 2019 10:08:15 +0100
In-Reply-To: <20190211163829.10297-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Mon, 11 Feb 2019 17:38:29 +0100")
Message-ID: <87imxppe68.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com

Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/kconfig.rst | 284 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 284 insertions(+)
>  create mode 100644 docs/devel/kconfig.rst
>
> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> new file mode 100644
> index 0000000000..b653c43b12
> --- /dev/null
> +++ b/docs/devel/kconfig.rst
> @@ -0,0 +1,284 @@
> +Introduction
> +------------
> +
> +QEMU is a very versatile emulator; it can be built for a variety of targets, where
> +each target can emulate various boards and at the same time different targets can
> +share large amounts of code.  For example, a POWER and an x86 boards can run the
> +same code to emulate a PCI network card, even though the boards use different PCI
> +host bridges, and they can run the same code to emulate a SCSI disk while using
> +different SCSI adapters.  ARM, s390 and x86 boards can both present a virtio-blk
> +disk to their guests, but with three different virtio guest interfaces.
> +

Please wrap your lines at column 70 or so.  Humans tend to have trouble
following long lines with their eyes (I sure do).  Typographic manuals
suggest to limit columns to roughly 60 characters for exactly that
reason[*].

> +Each QEMU target enables a subset of the boards, devices and buses that are included
> +in QEMU's source code.  As a result, each QEMU executable only links a small subset

Really?  Hmm...

$ size aarch64-softmmu/qemu-system-aarch64
   text	   data	    bss	    dec	    hex	filename
19183216	7200124	 592732	26976072	19b9f48	aarch64-softmmu/qemu-system-aarch64
$ size -t `find -name \*.o `| grep TOT
92713559	18652227	1183961440	1295327226	4d351ffa	(TOTALS)

Yep, really.

> +of the files that form QEMU's source code; anything that is not needed to support
> +a particular target is culled.
> +
> +QEMU uses a simple domain-specific language to describe the dependencies between
> +components.  This is useful for two reasons:
> +
> +* new targets and boards can be added without knowing in detail the architecture of
> +  the hardware emulation subsystems.  Boards only have to list the components they
> +  need, and the compiled executable will include all the required dependencies and
> +  all the devices that the user can add to that board.
> +
> +* users can easily build reduced versions of QEMU that support only a subset of
> +  boards or devices.  For example, by default most targets will include all emulated
> +  PCI devices that QEMU supports, but the build process is configurable and it is easy
> +  to drop unnecessary (or otherwise unwanted) code to make a leaner binary;
> +
> +This domain-specific language is based on the Kconfig language that originated in the
> +Linux kernel, though it was heavily simplified and the handling of dependencies is
> +stricter in QEMU.
> +
> +Unlike Linux, there is no user interface to edit the configuration, which is instead
> +specified in per-target files under the ``default-configs/`` directory of the
> +QEMU source tree.  This is because, unlike Linux, configuration and dependencies can be
> +treated as a black box when building QEMU; the default configuration that QEMU
> +ships with should be okay in almost all cases.
> +
> +The Kconfig language
> +--------------------
> +
> +Kconfig defines configurable components in files named ``hw/*/Kconfig``.
> +Note that configurable components are _not_ visible in C code as preprocessor symbols;
> +they are only visible in the Makefile.  Each configurable components
> +defines a Makefile variable whose name starts with ``CONFIG_``.
> +
> +All elements have boolean (true/false) type.  They are defined in a Kconfig
> +stanza like the following::
> +
> +      config ARM_VIRT
> +         bool
> +         imply PCI_DEVICES
> +         imply VFIO_AMD_XGBE
> +         imply VFIO_XGMAC
> +         select A15MPCORE
> +         select ACPI
> +         select ARM_SMMUV3
> +
> +The ``config`` keyword introduces a new configuration element.  In the example above,
> +Makefiles will have access to a variable named ``CONFIG_ARM_VIRT``, with value ``y`` or
> +``n`` (respectively for boolean true and false).
> +
> +The ``bool`` data type declaration is optional, but it is suggested to include it for
> +clarity and future-proofing.  After ``bool`` the following directives can be included:
> +
> +**dependencies**: ``depends on <expr>``
> +
> +  This defines a dependency for this configurable element. Dependencies
> +  evaluate an expression and force the value of the variable to false
> +  if the expression is false.
> +
> +  ``<expr>`` can be an arbitrary Boolean expression.  The ``&&``, ``||`` and ``!``
> +  operators are supported, respectively for conjunction (AND), disjunction
> +  (OR) and negation (NOT).
> +
> +**reverse dependencies**: ``select <symbol> [if <expr>]``
> +
> +  While ``depends on`` forces a symbol to false, reverse dependencies can be
> +  used to force another symbol to true.  In the following example,
> +  ``CONFIG_BAZ`` will be true whenever ``CONFIG_FOO`` is true::
> +
> +    config FOO
> +      select BAZ
> +
> +  The optional expression will prevent ``select`` from having any effect
> +  unless it is true.
> +
> +  Note that unlike Linux, QEMU will detect contradictions between ``depends on`` and
> +  ``select`` statements and prevent you from building such a configuration.
> +
> +**default value**: ``default <value> [if <expr>]``
> +
> +  Default values are assigned to the config symbol if no other
> +  value was set by the user via ``default-configs/*.mak`` files, and only if
> +  ``select`` or ``depends on`` directives do not force the value to true or
> +  false respectively.
> +
> +  Optionally, a condition for applying the default value can be added with
> +  ``if``.  A config option can have any number of default values (usually, if more than
> +  one default is present, they will have different conditions). If multiple
> +  default values satisfy their condition, only the first defined one is active.

Hmm.  Is "multiple default values, first one wins" a healthy state?
How obvious is "first defined" to humans?  

> +
> +**reverse default** (weak reverse dependency): ``imply <symbol> [if <expr>]``

If "reverse default" can be regarded as weak reverse dependency, could
"default value" be regarded as weak (forward) dependency?

> +
> +  This is similar to ``select`` as it applies a lower limit of ``y`` to another
> +  symbol.  However, the lower limit is only a default and the "implied" symbol's
> +  value may still be set to ``n`` from a ``default-configs/*.mak`` files.  The

I'm afraid I don't get "lower limit".  What's the ordering relation?

> +  following two examples are equivalent::
> +
> +    config FOO
> +      bool
> +      imply BAZ
> +
> +    config BAZ
> +      bool
> +      default y if FOO
> +
> +  The next section explains where to use ``imply`` or ``default y``.
> +
> +Guidelines for writing Kconfig files
> +------------------------------------
[...]

Good work, I like it!


[*] https://en.wikipedia.org/wiki/Column_(typography)#Typographic_style
