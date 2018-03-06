Received: from eggs.gnu.org ([2001:4830:134:3::10]:44860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHa1-0002Mg-2q
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHZy-00089Z-0V
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:44:53 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHZx-00089L-NK
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:44:49 -0500
Received: by mail-wm0-x244.google.com with SMTP id q83so97699wme.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 10:44:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306154625.23910-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2b197711-fb0a-afaa-0a33-9c0b5ade9c7a@amsat.org>
Date: Tue, 6 Mar 2018 15:44:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180306154625.23910-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] trace: only permit standard C types and
 fixed size integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

On 03/06/2018 12:46 PM, Daniel P. Berrangé wrote:
> Some trace backends will compile code based on the declared trace
> events. It should not be assumed that the backends can resolve any QEMU
> specific typedefs. So trace events should restrict their argument
> types to the standard C types and fixed size integer types. Any complex
> pointer types can be declared as "void *" for purposes of trace events,
> since nothing will be dereferencing these pointer arguments.

Exactly what I was thinking of!

> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 45 +++++++++++++++++++++++++++++++++++++++++++
>  trace-events                  |  6 +++---

Maybe split in 2 different patches?

>  2 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 3646c2b9fc..52cc687ae3 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -41,6 +41,50 @@ def out(*lines, **kwargs):
>      lines = [ l % kwargs for l in lines ]
>      sys.stdout.writelines("\n".join(lines) + "\n")
>  
> +# We only want to allow standard C types or fixed sized
> +# integer types. We don't want QEMU specific types
> +# as we can't assume trace backends can resolve all the
> +# typedefs
> +ALLOWED_TYPES = [
> +    "int",
> +    "long",
> +    "short",
> +    "char",
> +    "bool",
> +    "unsigned",
> +    "signed",
> +    "float",
> +    "double",
> +    "int8_t",
> +    "uint8_t",
> +    "int16_t",
> +    "uint16_t",
> +    "int32_t",
> +    "uint32_t",
> +    "int64_t",
> +    "uint64_t",
> +    "void",
> +    "size_t",
> +    "ssize_t",
> +    "uintptr_t",

ptrdiff_t?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    # Magic substitution is done by tracetool
> +    "TCGv",
> +]
> +
> +def validate_type(name):
> +    bits = name.split(" ")
> +    for bit in bits:
> +        bit = re.sub("\*", "", bit)
> +        if bit == "":
> +            continue
> +        if bit == "const":
> +            continue
> +        if bit not in ALLOWED_TYPES:
> +            raise ValueError("Argument type '%s' is not in whitelist. "
> +                             "Only standard C types and fixed size integer "
> +                             "types should be used. struct, union, and "
> +                             "other complex pointer types should be "
> +                             "declared as 'void *'" % name)
>  
>  class Arguments:
>      """Event arguments description."""
> @@ -87,6 +131,7 @@ class Arguments:
>              else:
>                  arg_type, identifier = arg.rsplit(None, 1)
>  
> +            validate_type(arg_type)
>              res.append((arg_type, identifier))
>          return Arguments(res)
>  
> diff --git a/trace-events b/trace-events
> index 89fcad0fd1..855b0ab240 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -68,9 +68,9 @@ memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, unsigned siz
>  memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -flatview_new(FlatView *view, MemoryRegion *root) "%p (root %p)"
> -flatview_destroy(FlatView *view, MemoryRegion *root) "%p (root %p)"
> -flatview_destroy_rcu(FlatView *view, MemoryRegion *root) "%p (root %p)"
> +flatview_new(void *view, void *root) "%p (root %p)"
> +flatview_destroy(void *view, void *root) "%p (root %p)"
> +flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
>  
>  # gdbstub.c
>  gdbstub_op_start(const char *device) "Starting gdbstub using device %s"
> 
