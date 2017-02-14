Received: from eggs.gnu.org ([2001:4830:134:3::10]:48917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdhaR-0005bM-SW
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdhaN-0000ic-PD
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:12:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cdhaN-0000iP-G4
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:12:19 -0500
Date: Tue, 14 Feb 2017 13:12:17 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170214181217.GS27752@localhost.localdomain>
References: <1478566785-4002-1-git-send-email-ashish.mittal@veritas.com>
	<1478566785-4002-3-git-send-email-ashish.mittal@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478566785-4002-3-git-send-email-ashish.mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] block/vxhs.c: Add qemu-iotests for
 new block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, Rakesh.Ranjan@veritas.com, Buddhi.Madhav@veritas.com, Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com, Venkatesha.Mg@veritas.com

On Mon, Nov 07, 2016 at 04:59:45PM -0800, Ashish Mittal wrote:
> These changes use a vxhs test server that is a part of the following
> repository:
> https://github.com/MittalAshish/libqnio.git
> 
> Signed-off-by: Ashish Mittal <ashish.mittal@veritas.com>
> ---
> v6 changelog:
> (1) Added iotests for VxHS block device.
> 
>  tests/qemu-iotests/common        |  6 ++++++
>  tests/qemu-iotests/common.config | 13 +++++++++++++
>  tests/qemu-iotests/common.filter |  1 +
>  tests/qemu-iotests/common.rc     | 19 +++++++++++++++++++
>  4 files changed, 39 insertions(+)
> 

[...]

> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 240ed06..a8a4d0e 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -123,6 +123,7 @@ _filter_img_info()
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
>          -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
> +        -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
>          -e "/encrypted: yes/d" \
>          -e "/cluster_size: [0-9]\\+/d" \
>          -e "/table_size: [0-9]\\+/d" \
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 3213765..06a3164 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -89,6 +89,9 @@ else
>          TEST_IMG=$TEST_DIR/t.$IMGFMT
>      elif [ "$IMGPROTO" = "archipelago" ]; then
>          TEST_IMG="archipelago:at.$IMGFMT"
> +    elif [ "$IMGPROTO" = "vxhs" ]; then
> +        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
> +        TEST_IMG="vxhs://127.0.0.1:9999/t.$IMGFMT"
>      else
>          TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
>      fi
> @@ -175,6 +178,12 @@ _make_test_img()
>          eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IMG_FILE &"
>          sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
>      fi
> +
> +    # Start QNIO server on image directory for vxhs protocol
> +    if [ $IMGPROTO = "vxhs" ]; then
> +        eval "$QEMU_VXHS -d  $TEST_DIR &"

So I spoke too soon about tests passing, but it is not really your fault :)

After rebasing to master, there is a new test 174 that now hangs (and hangs
for nbd, as well).  This is because the test is piping the results of
_make_test_image to sed to filter it.

This line should redirect stdout to /dev/null, so that the pipe does not
need to wait until process completion:

    eval "$QEMU_VXHS -d  $TEST_DIR > /dev/null &"

 
