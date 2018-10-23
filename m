Received: from eggs.gnu.org ([2001:4830:134:3::10]:51715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEwir-0000Lj-QE
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEwio-0006Gv-Hv
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:27:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEwio-0006GL-9Q
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:27:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so1707499wrw.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 06:27:46 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2eb3d12f-1a2b-8194-e1a4-cfd6396f3aa5@redhat.com>
Date: Tue, 23 Oct 2018 15:27:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] decodetree: Add !extern flag to
 argument sets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 23/10/18 14:04, Richard Henderson wrote:
> Allow argument sets to be shared between two decoders by avoiding
> a re-declaration error.  Make sure that anonymous argument sets
> have unique names.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 277f9a9bba..a9b10452ef 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -63,13 +63,16 @@
>   #
>   # *** Argument set syntax:
>   #
> -# args_def    := '&' identifier ( args_elt )+
> +# args_def    := '&' identifier ( args_elt )+ ( !extern )?
>   # args_elt    := identifier
>   #
>   # Each args_elt defines an argument within the argument set.
>   # Each argument set will be rendered as a C structure "arg_$name"
>   # with each of the fields being one of the member arguments.
>   #
> +# If !extern is specified, the backing structure is assumed to
> +# have been already declared, typically via a second decoder.
> +#
>   # Argument set examples:
>   #
>   #   &reg3       ra rb rc
> @@ -169,6 +172,7 @@ input_file = ''
>   output_file = None
>   output_fd = None
>   insntype = 'uint32_t'
> +decode_function = 'decode'
>   
>   re_ident = '[a-zA-Z][a-zA-Z0-9_]*'
>   
> @@ -394,8 +398,9 @@ class FunctionField:
>   
>   class Arguments:
>       """Class representing the extracted fields of a format"""
> -    def __init__(self, nm, flds):
> +    def __init__(self, nm, flds, extern):
>           self.name = nm
> +        self.extern = extern
>           self.fields = sorted(flds)
>   
>       def __str__(self):
> @@ -405,10 +410,11 @@ class Arguments:
>           return 'arg_' + self.name
>   
>       def output_def(self):
> -        output('typedef struct {\n')
> -        for n in self.fields:
> -            output('    int ', n, ';\n')
> -        output('} ', self.struct_name(), ';\n\n')
> +        if not self.extern:
> +            output('typedef struct {\n')
> +            for n in self.fields:
> +                output('    int ', n, ';\n')
> +            output('} ', self.struct_name(), ';\n\n')
>   # end Arguments
>   
>   
> @@ -542,7 +548,11 @@ def parse_arguments(lineno, name, toks):
>       global re_ident
>   
>       flds = []
> +    extern = False
>       for t in toks:
> +        if re_fullmatch('!extern', t):
> +            extern = True

It looks odd to match a negative form then use a positive one.

Why not simply use 'extern'?

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +            continue
>           if not re_fullmatch(re_ident, t):
>               error(lineno, 'invalid argument set token "{0}"'.format(t))
>           if t in flds:
> @@ -551,7 +561,7 @@ def parse_arguments(lineno, name, toks):
>   
>       if name in arguments:
>           error(lineno, 'duplicate argument set', name)
> -    arguments[name] = Arguments(name, flds)
> +    arguments[name] = Arguments(name, flds, extern)
>   # end parse_arguments
>   
>   
> @@ -575,13 +585,14 @@ def add_field_byname(lineno, flds, new_name, old_name):
>   
>   def infer_argument_set(flds):
>       global arguments
> +    global decode_function
>   
>       for arg in arguments.values():
>           if eq_fields_for_args(flds, arg.fields):
>               return arg
>   
> -    name = str(len(arguments))
> -    arg = Arguments(name, flds.keys())
> +    name = decode_function + str(len(arguments))
> +    arg = Arguments(name, flds.keys(), False)
>       arguments[name] = arg
>       return arg
>   
> @@ -589,6 +600,7 @@ def infer_argument_set(flds):
>   def infer_format(arg, fieldmask, flds):
>       global arguments
>       global formats
> +    global decode_function
>   
>       const_flds = {}
>       var_flds = {}
> @@ -608,7 +620,7 @@ def infer_format(arg, fieldmask, flds):
>               continue
>           return (fmt, const_flds)
>   
> -    name = 'Fmt_' + str(len(formats))
> +    name = decode_function + '_Fmt_' + str(len(formats))
>       if not arg:
>           arg = infer_argument_set(flds)
>   
> @@ -973,8 +985,8 @@ def main():
>       global insnwidth
>       global insntype
>       global insnmask
> +    global decode_function
>   
> -    decode_function = 'decode'
>       decode_scope = 'static '
>   
>       long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=']
> 
