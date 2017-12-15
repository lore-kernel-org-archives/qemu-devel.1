Received: from eggs.gnu.org ([2001:4830:134:3::10]:36852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuc7-0004tc-Ku
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuc3-0001VW-JE
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:21:39 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuc3-0001VI-Ex
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:21:35 -0500
Received: by mail-qk0-x241.google.com with SMTP id b184so11442326qkc.13
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:21:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48823054-88be-e115-1b76-d772947170e8@amsat.org>
Date: Fri, 15 Dec 2017 15:21:32 -0300
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/13] build-sys: fix qemu-ga -pthread
 linking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Hi Marc-André,

On 12/15/2017 12:06 PM, Marc-André Lureau wrote:
> When linking qemu-ga under some configuration (when gthread-2.0.pc
> doesn't have -pthread, as happening atm with meson build), you may
> have this linking issue:
> 
> /usr/bin/ld: libqemuutil.a(qemu-thread-posix.o): undefined reference to symbol 'pthread_setname_np@@GLIBC_2.12'
> /usr/lib64/libpthread.so.0: error adding symbols: DSO missing from command line
> 
> Make sure qemu-ga links with the pthread library, by adding correct
> flags to libs_qga.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configure b/configure
> index 0c6e7572db..2b8c71f522 100755
> --- a/configure
> +++ b/configure
> @@ -3436,6 +3436,7 @@ else
>        done
>        if test "$found" = "no"; then
>          LIBS="$pthread_lib $LIBS"
> +        libs_qga="$pthread_lib $libs_qga"
>        fi
>        PTHREAD_LIB="$pthread_lib"
>        break

Hmm why not add it later, around line 4270:

if compile_prog "" "" ; then
  :
# we need pthread for static linking. use previous pthread test result
elif compile_prog "" "$pthread_lib -lrt" ; then
  LIBS="$LIBS -lrt"
  libs_qga="$libs_qga -lrt" #  <-- here
fi
