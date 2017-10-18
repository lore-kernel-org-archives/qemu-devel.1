Received: from eggs.gnu.org ([2001:4830:134:3::10]:43028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4pc6-0007J4-FI
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4pc0-0002Of-CF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:46:30 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:56628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4pc0-0002O6-5U
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:46:24 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so10728368wmd.5
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:46:24 -0700 (PDT)
References: <cover.1508257445.git.jcody@redhat.com>
	<503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
Date: Wed, 18 Oct 2017 16:46:20 +0200
MIME-Version: 1.0
In-Reply-To: <503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/10] qemu-iotests: automatically clean
 up bash protocol servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On 17/10/2017 18:31, Jeff Cody wrote:
>              )
>          else
> +            # Do this in a sub-shell, so we are operating on the right
> +            # TEST_DIR / QEMU_TEST_DIR
>              (
>              export TEST_DIR=$TEST_DIR_SEQ
>              cd "$source_iotests";

Where is the missing ")"?

> @@ -837,6 +841,15 @@ do
>              fi
>          fi
>  
> +        # Do this in a sub-shell, so we are operating on the right
> +        # TEST_DIR / QEMU_TEST_DIR
> +        (
> +        export TEST_DIR=$TEST_DIR_SEQ
> +        . "$source_iotests/common.config"
> +        . "$source_iotests/common.rc"
> +
> +        _cleanup_protocols

"check" wasn't including common.rc before this patch, and most of the
content of that file doesn't apply to "check".  So if we want to move
cleanup code to "check" we should remove it from common.rc too.

In general, I think we should strive to have a better separation between
tests and harness.  This for example could let us write a different
harness for the same tests and integrate the tests better into Avocado.
Hence I see one advantage and one disadvantage in your series:

* by adding more functionality to "check", it shows that the current
separation may fail with a more sophisticated harness (such as the one
you are creating here)

* it adds a lot more knowledge of QEMU (especially protocols) in
"check", but there is still some unbalance: tests create the images and
the protocol servers, but the harness cleans it up.  The visible result
of this unbalance is for example how multi-process protocol tests can
fail when multiple tests try to bind the same address.

I think it's the right direction, but it feels like it's not there
yet...  Sorry---I know this is not very constructive, but I hope it
helps anyway.

Maybe we should actually rewrite "check" in Python.  That would force us
to think more about the design.

Paolo
