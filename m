Received: from eggs.gnu.org ([2001:4830:134:3::10]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3GMT-0000dl-9a
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3GMR-0000Nm-TD
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:23:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 26 Apr 2017 02:23:13 -0400
Message-Id: <1493187803-4510-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 00/10] TCG optimizations for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

This is the v3 of this series. v2 for context:
  https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04342.html

Changes from v2 -- all due to Richard's comments:

- Inlined tb_from_jmp_cache into the TCG helper; now that this helper
  is common there is no point in having a separate function for this.

- Compile-tested for all targets.

- Dropped the TCG alignment patches for now.

- Added reviewed-by tags.

- Removed stray goto_tb from tcg_dump_ops. (That was a leftover
  that should have been removed long ago.)

- merged helper_lookup_tb_ptr and goto_ptr into gen_lookup_and_goto_ptr.
  This makes the calling code simpler and also prunes out the lookup
  when goto_ptr isn't implemented by the backend.

- tcg/i386: add the "pre-epilogue" instruction that sets eax to 0,
  instead of setting eax to 0 before every goto_ptr.

- return "r" instead of "ri" for goto_ptr's op def. (*ouch!*)

- target/arm: extend to tl before calling the lookup_and_goto_ptr
  helper, thereby fixing aarch64-* target compilation.

Also re-ran all measurements, and dropped the noinline measurements
since now there's only a single (inlined) caller.
You can inspect/fetch the changes at:
  https://github.com/cota/qemu/tree/tcg-opt-v3

Thanks,

		Emilio
