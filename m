Received: from eggs.gnu.org ([2001:4830:134:3::10]:39087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyZqk-0008Eh-Hz
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyZqh-0006Z5-BP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:16:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eyZqh-0006Yd-1R
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:15:59 -0400
References: <20180320142343.13867-1-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bec59193-cb03-b300-474c-e8692f336e33@vivier.eu>
Date: Wed, 21 Mar 2018 10:15:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180320142343.13867-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] make: improve check for stale generated
 files in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Le 20/03/2018 à 15:23, Daniel P. Berrangé a écrit :
> When doing a build with builddir != srcdir, if any generated files are
> accidentally present in srcdir from a previous build, these can cause
> unexpected failures.
> 
> Currently there is a rule that checks for existance of config-host.mak,
> but there have been cases where config-host.mak is absent, while other
> generated files still exist.
> 
> Update the check to look at every file listed in $(GENERATED_FILES). To
> do this we must move the check further down after $(GENERATED_FILES) has
> been populated.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  Makefile | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)

Tested-by: Laurent Vivier <laurent@vivier.eu>

I had a stale qemu-version.h and this change has correctly detected it.

The problem was:

$ make -C build/all
...
./qemu-nbd.c: In function ‘version’:
./qemu-nbd.c:133:7: error: expected ‘)’ before ‘QEMU_FULL_VERSION’
 "%s " QEMU_FULL_VERSION "\n"
       ^~~~~~~~~~~~~~~~~
./qemu-nbd.c:133:3: error: format ‘%s’ expects a matching ‘char *’
argument [-Werror=format=]
 "%s " QEMU_FULL_VERSION "\n"
  ~^
cc1: all warnings being treated as errors
make: *** [./rules.mak:66: qemu-nbd.o] Error 1
make: *** Waiting for unfinished jobs....
make: Leaving directory './build/all'

once the file removed, the build can be done.

Thanks,
Laurent
