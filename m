Received: from eggs.gnu.org ([2001:4830:134:3::10]:33334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS3Z1-0004hj-92
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS3Yu-0001Gn-Nv
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:23:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gS3Yq-0000sj-FI
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:23:42 -0500
Date: Wed, 28 Nov 2018 12:23:32 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181128172332.GA16387@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-42-cota@braap.org>
	<20181127124352.ll6quqc5xedvdqht@MacBook-Pro-Roman.local>
	<20181127231357.GA19764@flamenco>
	<20181128104330.qkqnfttswihjur6g@MacBook-Pro-Roman.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128104330.qkqnfttswihjur6g@MacBook-Pro-Roman.local>
Subject: Re: [Qemu-devel] [RFC 41/48] configure: add --enable-plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>

On Wed, Nov 28, 2018 at 13:43:30 +0300, Roman Bolshakov wrote:
> The test of -exported_symbols_list fails:
> Undefined symbols for architecture x86_64:
>   "foo", referenced from:
>        -exported_symbol[s_list] command line option
>             (maybe you meant: _foo)
> 
> All functions on macOS are prefixed with underscore [1]:
> "The name of a symbol representing a function that conforms to standard C
> calling conventions is the name of the function with an underscore prefix.
> Thus, the name of the symbol representing the function main would be _main."
> 
> So it can be fixed by prepending foo and qemu-plugins-ld64.symbols with
> underscore:

Ah I see, thanks!

(snip)
> qemu-ga fails to link because it doesn't have symbols declared in
> qemu-plugins-ld64.symbols. Perhaps "-Wl,-exported_symbols_list" should
> be applied only to qemu-system?

I just pushed to the same github branch the appended fixup.
The idea is to only add the linker flags when the output
binary links plugin.o.

Can you please test?

Thanks,

		Emilio

---
commit 8f45416b79765b66e5ce0fca7db93b97bbcfcfbb
Author: Emilio G. Cota <cota@braap.org>
Date:   Wed Nov 28 12:11:23 2018 -0500

    configure: ld64 fixup
    
    And copy the file to the build dir also for !ld64.
    
    Signed-off-by: Emilio G. Cota <cota@braap.org>

diff --git a/Makefile.target b/Makefile.target
index 719699696d..7ea17d71cb 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -107,7 +107,23 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 
-obj-$(CONFIG_PLUGINS) += plugin.o
+ifdef CONFIG_PLUGINS
+obj-y += plugin.o
+# Abuse -libs suffix to only link with --dynamic-list/-exported_symbols_list
+# when the final binary includes the plugin object.
+#
+# Note that simply setting LDFLAGS is not enough: we build binaries that
+# never link plugin.o, and the linker might fail (at least ld64 does)
+# if the symbols in the list are not in the output binary.
+ ifdef CONFIG_HAS_LD_DYNAMIC_LIST
+ plugin.o-libs := -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
+ else
+  ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
+  plugin.o-libs := \
+	-Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
+  endif
+ endif
+endif
 
 #########################################################
 # Linux user emulator target
diff --git a/configure b/configure
index 3dc9c9697b..395acf831e 100755
--- a/configure
+++ b/configure
@@ -5185,7 +5185,7 @@ fi
 # See if -exported_symbols_list is supported by the linker
 
 cat > $TMPTXT <<EOF
-  foo
+  _foo
 EOF
 
 ld_exported_symbols_list="no"
@@ -6843,13 +6843,17 @@ fi
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGINS=y" >> $config_host_mak
     LIBS="-ldl $LIBS"
+    # Copy the export object list to the build dir
     if test "$ld_dynamic_list" = "yes" ; then
-	LDFLAGS="-Wl,--dynamic-list=\$(SRC_PATH)/qemu-plugins.symbols $LDFLAGS"
+	echo "CONFIG_HAS_LD_DYNAMIC_LIST=yes" >> $config_host_mak
+	ld_symbols=qemu-plugins-ld.symbols
+	cp "$source_path/qemu-plugins.symbols" $ld_symbols
     elif test "$ld_exported_symbols_list" = "yes" ; then
+	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=yes" >> $config_host_mak
 	ld64_symbols=qemu-plugins-ld64.symbols
 	echo "# Automatically generated by configure - do not modify" > $ld64_symbols
-	cat "$source_path/qemu-plugins.symbols" | grep qemu_ | sed 's/;//g' >> $ld64_symbols
-	LDFLAGS="-Wl,-exported_symbols_list,\$(BUILD_DIR)/$ld64_symbols $LDFLAGS"
+	grep 'qemu_' "$source_path/qemu-plugins.symbols" | sed 's/;//g' | \
+	    sed -E 's/^\s*(.*)/_\1/' >> $ld64_symbols
     else
 	error_exit \
 	    "If \$plugins=yes, either \$ld_dynamic_list or " \
