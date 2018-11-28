Received: from eggs.gnu.org ([2001:4830:134:3::10]:58747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gRxJk-0006DH-JZ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gRxJf-00065B-Jt
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:43:40 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:47552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gRxJf-00064G-6w
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:43:35 -0500
Date: Wed, 28 Nov 2018 13:43:30 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20181128104330.qkqnfttswihjur6g@MacBook-Pro-Roman.local>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-42-cota@braap.org>
	<20181127124352.ll6quqc5xedvdqht@MacBook-Pro-Roman.local>
	<20181127231357.GA19764@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181127231357.GA19764@flamenco>
Subject: Re: [Qemu-devel] [RFC 41/48] configure: add --enable-plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>

On Tue, Nov 27, 2018 at 06:13:57PM -0500, Emilio G. Cota wrote:
> On Tue, Nov 27, 2018 at 15:43:52 +0300, Roman Bolshakov wrote:
> > ld64 on macOS has similar -exported_symbols_list option. Here's the reference:
> > 
> >      -exported_symbols_list filename
> > 	The specified filename contains a list of global symbol names
> > 	that will remain as global symbols in the output file.  All other
> > 	global symbols will be treated as if they were marked as
> > 	__private_extern__ (aka visibility=hidden) and will not be global in
> > 	the output file. The symbol names listed in filename must be one per
> > 	line.  Leading and trailing white space are not part of the symbol
> > 	name.  Lines starting with # are ignored, as are lines with only white
> > 	space.  Some wildcards (similar to shell file matching) are supported.
> > 	The * matches zero or more characters.  The ?  matches one character.
> > 	[abc] matches one character which must be an 'a', 'b', or 'c'.
> > 	[a-z] matches any single lower case letter from 'a' to 'z'.
> > 
> > 
> > I can try your branch if you add support of the linker flag or send required
> > changes via GitHub.
> 
> Can you please try this branch? I added a commit with the appended.
>   https://github.com/cota/qemu/tree/plugin-v2
> 
> You can inspect the symbols in the final binary with
> `readelf --dyn-syms' or `nm -D'.
> 
> Thanks,
> 
> 		Emilio
> 
> ---
> diff --git a/configure b/configure
> index fe9707d951..3dc9c9697b 100755
> --- a/configure
> +++ b/configure
> @@ -5176,15 +5176,31 @@ int main(void)
>  }
>  EOF
>  
> +ld_dynamic_list="no"
>  if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
>    ld_dynamic_list="yes"
> -else
> -  if test "$plugins" = "yes" ; then
> -    error_exit \
> -        "Plugin support requires specifying a set of symbols that " \
> -        "are exported to plugins. Unfortunately your linker doesn't " \
> -        "support the flag (--dynamic-list) used for this purpose."
> -  fi
> +fi
> +
> +#########################################
> +# See if -exported_symbols_list is supported by the linker
> +
> +cat > $TMPTXT <<EOF
> +  foo
> +EOF
> +
> +ld_exported_symbols_list="no"
> +if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
> +  ld_exported_symbols_list="yes"
> +fi
> +
> +if  test "$plugins" = "yes" &&
> +    test "$ld_dynamic_list" = "no" &&
> +    test "$ld_exported_symbols_list" = "no" ; then
> +  error_exit \
> +      "Plugin support requires specifying a set of symbols that " \
> +      "are exported to plugins. Unfortunately your linker doesn't " \
> +      "support the flag (--dynamic-list or -exported_symbols_list) used " \
> +      "for this purpose."
>  fi
>  
>  ########################################
> @@ -6827,7 +6843,18 @@ fi
>  if test "$plugins" = "yes" ; then
>      echo "CONFIG_PLUGINS=y" >> $config_host_mak
>      LIBS="-ldl $LIBS"
> -    LDFLAGS="-Wl,--dynamic-list=\$(SRC_PATH)/qemu-plugins.symbols $LDFLAGS"
> +    if test "$ld_dynamic_list" = "yes" ; then
> +	LDFLAGS="-Wl,--dynamic-list=\$(SRC_PATH)/qemu-plugins.symbols $LDFLAGS"
> +    elif test "$ld_exported_symbols_list" = "yes" ; then
> +	ld64_symbols=qemu-plugins-ld64.symbols
> +	echo "# Automatically generated by configure - do not modify" > $ld64_symbols
> +	cat "$source_path/qemu-plugins.symbols" | grep qemu_ | sed 's/;//g' >> $ld64_symbols
> +	LDFLAGS="-Wl,-exported_symbols_list,\$(BUILD_DIR)/$ld64_symbols $LDFLAGS"
> +    else
> +	error_exit \
> +	    "If \$plugins=yes, either \$ld_dynamic_list or " \
> +	    "\$ld_exported_symbols_list should have been set to 'yes'."
> +    fi
>  fi
>  
>  if test "$tcg_interpreter" = "yes"; then
> 

Hi Emilio,

The test of -exported_symbols_list fails:
Undefined symbols for architecture x86_64:
  "foo", referenced from:
       -exported_symbol[s_list] command line option
            (maybe you meant: _foo)

All functions on macOS are prefixed with underscore [1]:
"The name of a symbol representing a function that conforms to standard C
calling conventions is the name of the function with an underscore prefix.
Thus, the name of the symbol representing the function main would be _main."

So it can be fixed by prepending foo and qemu-plugins-ld64.symbols with
underscore:

diff --git a/configure b/configure
index 3dc9c9697b..85dd15732c 100755
--- a/configure
+++ b/configure
@@ -5185,7 +5185,7 @@ fi
 # See if -exported_symbols_list is supported by the linker

 cat > $TMPTXT <<EOF
-  foo
+  _foo
 EOF

 ld_exported_symbols_list="no"
@@ -6848,7 +6848,7 @@ if test "$plugins" = "yes" ; then
     elif test "$ld_exported_symbols_list" = "yes" ; then
        ld64_symbols=qemu-plugins-ld64.symbols
        echo "# Automatically generated by configure - do not modify" > $ld64_symbols
-       cat "$source_path/qemu-plugins.symbols" | grep qemu_ | sed 's/;//g' >> $ld64_symbols
+        cat "$source_path/qemu-plugins.symbols" | sed -nE 's/^([[:space:]]+)(.+);/\1_\2/p' >> $ld64_symbols
        LDFLAGS="-Wl,-exported_symbols_list,\$(BUILD_DIR)/$ld64_symbols $LDFLAGS"
     else
        error_exit \

--

Then if I print globally defined functions I can see it in
config-temp/qemu-conf.exe:

nm -g -U config-temp/qemu-conf.exe
0000000100000f50 T _foo

qemu-ga fails to link because it doesn't have symbols declared in
qemu-plugins-ld64.symbols. Perhaps "-Wl,-exported_symbols_list" should
be applied only to qemu-system?

[1] https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/MachOTopics/1-Articles/executing_files.html#//apple_ref/doc/uid/TP40001829-97182-TPXREF112

Best regards,
Roman
