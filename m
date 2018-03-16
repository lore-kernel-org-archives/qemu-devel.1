Received: from eggs.gnu.org ([2001:4830:134:3::10]:51223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewu3K-0004qJ-Sg
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewu3J-0004P6-VP
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:26:06 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:41707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewu3J-0004OI-Ox
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:26:05 -0400
Received: by mail-ot0-x22e.google.com with SMTP id i28-v6so6599914otf.8
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:26:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c4054b32-b2e1-acd3-52f4-8f7d5c12c2a0@de.ibm.com>
References: <20180316170122.fmo2nghyxpeaq7hp@kamzik.brq.redhat.com>
	<a876446f-d4a4-4df2-c986-4e45a64b9436@redhat.com>
	<c4054b32-b2e1-acd3-52f4-8f7d5c12c2a0@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 18:25:44 +0000
Message-ID: <CAFEAcA8J1nTtCX04kHmbb1v2rpUgWAZ9OZpQWou+tGe=1YtwoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu master build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2018 at 18:12, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Does it make sense to have something like
>
> diff --git a/configure b/configure
> index 831ebf2..67d7ae3 100755
> --- a/configure
> +++ b/configure
> @@ -552,6 +552,10 @@ else
>      pwd_is_source_path="n"
>  fi
>
> +if test -f $source_path\/qemu-version.h -a $pwd_is_source_path = "n" ; then
> +error_exit "source path contains a stale configuration, cannot build outside"
> +fi

We already have an equivalent check to that in Makefile;
it looks for a config-host.mak:

# Check that we're not trying to do an out-of-tree build from
# a tree that's been used for an in-tree build.
ifneq ($(realpath $(SRC_PATH)),$(realpath .))
ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
$(error This is an out of tree build but your source tree ($(SRC_PATH)) \
seems to have been used for an in-tree build. You can fix this by running \
"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree)
endif
endif


Before commit 428952cfa966f it was possible for an accidental
run of 'make -j10' in the source tree to create qemu-options.def
and qemu-version.h in the source tree before the makefile noticed
you were trying it in the wrong directory. I think that after
that it should be much harder to end up with these stale files,
but of course if your tree already had a stale file from
before then the commit won't clean it up for you...

thanks
-- PMM
