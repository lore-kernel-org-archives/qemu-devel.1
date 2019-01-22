Received: from eggs.gnu.org ([209.51.188.92]:35281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm5lK-0007KM-Is
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 18:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm5j9-0004Yj-Gz
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 18:45:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gm5j9-0004Wm-1o
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 18:45:07 -0500
Date: Tue, 22 Jan 2019 18:45:02 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190122234502.GA9839@flamenco>
References: <20190122215016.18697-1-alex.bennee@linaro.org>
	<20190122215016.18697-10-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122215016.18697-10-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 09/11] tests/Makefile: add floating
 point tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, Jan 22, 2019 at 21:50:14 +0000, Alex Bennée wrote:
> Wire up test/fp-test into the main testing Makefile. Currently we skip
> some of the extF80 and f128 related tests. Once we re-factor and fix
> these tests the plumbing should get simpler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(snip)
> +# FPU Emulation tests (aka softfloat)
> +#
> +# As we still have some places that need fixing the rules are a little
> +# more complex than they need to be and have to override some of the
> +# generic Makefile expansions. Once we are cleanly passing all
> +# the tests we can simplify the make syntax.
> +
> +FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test
> +
> +# the build dir is created by configure
> +.PHONY: $(FP_TEST_BIN)
> +$(FP_TEST_BIN): $(BUILD_DIR)/tests/fp fpu/softfloat.c

I'd remove the prerequisites here: (1) tests/fp should have been
created by configure, and we're not adding a recipe for it here;
(2) fpu/softfloat.c is unnecessary, because the makefile in tests/fp
will take care of the prerequisites.

> +	$(call quiet-command, \
> +	  cd $(BUILD_DIR)/tests/fp && make, \
> +          "BUILD", $<)

I'd rather use $(MAKE) here, e.g. so that "-j" propagates.

With those two changes, the delta wrt the above would be:

 # the build dir is created by configure
 .PHONY: $(FP_TEST_BIN)
-$(FP_TEST_BIN): $(BUILD_DIR)/tests/fp fpu/softfloat.c
+$(FP_TEST_BIN):
        $(call quiet-command, \
-         cd $(BUILD_DIR)/tests/fp && make, \
-          "BUILD", $<)
+         $(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" $(notdir $@), \
+         "BUILD", "$(notdir $@)")

The rest looks good!

Thanks,

		Emilio
