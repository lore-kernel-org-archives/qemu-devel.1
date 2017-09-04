Received: from eggs.gnu.org ([2001:4830:134:3::10]:34522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dowe6-0007Or-2e
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dowe1-0004ln-41
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:02:54 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dowe0-0004lF-Q1
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:02:49 -0400
References: <20170904164659.26915-1-n54@gmx.com>
	<20170904173226.25252-1-n54@gmx.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1a66a487-b906-3f9f-6f4c-15e04c409903@vivier.eu>
Date: Mon, 4 Sep 2017 21:02:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170904173226.25252-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] target/m68k: Switch fpu_rom from
 make_floatx80() to make_floatx80_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, peter.maydell@linaro.org

Le 04/09/2017 à 19:32, Kamil Rytarowski a écrit :
> GCC 4.7.2 on SunOS reports that the values assigned to array members are not
> real constants:
> 
> target/m68k/fpu_helper.c:32:5: error: initializer element is not constant
> target/m68k/fpu_helper.c:32:5: error: (near initialization for 'fpu_rom[0]')
> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
> 
> Convert the array to make_floatx80_init() to fix it.
> Replace floatx80_pi-like constants with make_floatx80_init() as they are
> defined as make_floatx80().
> 
> This fixes build on SmartOS (Joyent).
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/m68k/fpu_helper.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index bdfc537c68..b3d50d1e01 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -29,28 +29,28 @@
>   */
>  
>  static const floatx80 fpu_rom[128] = {
> -    [0x00] = floatx80_pi,                                   /* Pi */
> -    [0x0b] = make_floatx80(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2) */
> -    [0x0c] = make_floatx80(0x4000, 0xadf85458a2bb4a9aULL),  /* e        */
> -    [0x0d] = make_floatx80(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)  */
> -    [0x0e] = make_floatx80(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e) */
> -    [0x0f] = floatx80_zero,                                 /* Zero     */
> -    [0x30] = floatx80_ln2,                                  /* ln(2)    */
> -    [0x31] = make_floatx80(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10)   */
> -    [0x32] = floatx80_one,                                  /* 10^0     */
> -    [0x33] = make_floatx80(0x4002, 0xa000000000000000ULL),  /* 10^1     */
> -    [0x34] = make_floatx80(0x4005, 0xc800000000000000ULL),  /* 10^2     */
> -    [0x35] = make_floatx80(0x400c, 0x9c40000000000000ULL),  /* 10^4     */
> -    [0x36] = make_floatx80(0x4019, 0xbebc200000000000ULL),  /* 10^8     */
> -    [0x37] = make_floatx80(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16    */
> -    [0x38] = make_floatx80(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32    */
> -    [0x39] = make_floatx80(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64    */
> -    [0x3a] = make_floatx80(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128   */
> -    [0x3b] = make_floatx80(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256   */
> -    [0x3c] = make_floatx80(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512   */
> -    [0x3d] = make_floatx80(0x4d48, 0xc976758681750c17ULL),  /* 10^1024  */
> -    [0x3e] = make_floatx80(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048  */
> -    [0x3f] = make_floatx80(0x7525, 0xc46052028a20979bULL),  /* 10^4096  */
> +    [0x00] = make_floatx80_init(0x4000, 0xc90fdaa22168c235LL),   /* Pi       */
> +    [0x0b] = make_floatx80_init(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2) */
> +    [0x0c] = make_floatx80_init(0x4000, 0xadf85458a2bb4a9aULL),  /* e        */
> +    [0x0d] = make_floatx80_init(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)  */
> +    [0x0e] = make_floatx80_init(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e) */
> +    [0x0f] = make_floatx80_init(0x0000, 0x0000000000000000LL),   /* Zero     */
> +    [0x30] = make_floatx80_init(0x3ffe, 0xb17217f7d1cf79acLL),   /* ln(2)    */
> +    [0x31] = make_floatx80_init(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10)   */
> +    [0x32] = make_floatx80_init(0x3fff, 0x8000000000000000LL),   /* 10^0     */
> +    [0x33] = make_floatx80_init(0x4002, 0xa000000000000000ULL),  /* 10^1     */
> +    [0x34] = make_floatx80_init(0x4005, 0xc800000000000000ULL),  /* 10^2     */
> +    [0x35] = make_floatx80_init(0x400c, 0x9c40000000000000ULL),  /* 10^4     */
> +    [0x36] = make_floatx80_init(0x4019, 0xbebc200000000000ULL),  /* 10^8     */
> +    [0x37] = make_floatx80_init(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16    */
> +    [0x38] = make_floatx80_init(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32    */
> +    [0x39] = make_floatx80_init(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64    */
> +    [0x3a] = make_floatx80_init(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128   */
> +    [0x3b] = make_floatx80_init(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256   */
> +    [0x3c] = make_floatx80_init(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512   */
> +    [0x3d] = make_floatx80_init(0x4d48, 0xc976758681750c17ULL),  /* 10^1024  */
> +    [0x3e] = make_floatx80_init(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048  */
> +    [0x3f] = make_floatx80_init(0x7525, 0xc46052028a20979bULL),  /* 10^4096  */
>  };
>  
>  int32_t HELPER(reds32)(CPUM68KState *env, FPReg *val)
> 

I don't want to be picky, but you should use "ULL" instead of "LL" for
the new values.

Thanks,
Laurent
