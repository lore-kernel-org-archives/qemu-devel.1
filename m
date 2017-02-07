Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbEwD-0003J1-B6
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbEwB-0005k6-Lm
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:12:41 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:33641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cbEwB-0005he-FW
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:12:39 -0500
Received: by mail-io0-x241.google.com with SMTP id 101so14343926iom.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 15:12:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161108204413.GA6353@localhost.localdomain>
References: <1478566785-4002-1-git-send-email-ashish.mittal@veritas.com>
	<1478566785-4002-3-git-send-email-ashish.mittal@veritas.com>
	<20161108204413.GA6353@localhost.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Tue, 7 Feb 2017 15:12:36 -0800
Message-ID: <CAAo6VWMyTjV1Fn8-BSex7Fx8OcEcuEyK2rQJ6L=wZZXDiB5A4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>

I plan to submit v7 soon, therefore going over any unanswered emails
at this time.

On Tue, Nov 8, 2016 at 12:44 PM, Jeff Cody <jcody@redhat.com> wrote:
> On Mon, Nov 07, 2016 at 04:59:45PM -0800, Ashish Mittal wrote:
>> These changes use a vxhs test server that is a part of the following
>> repository:
>> https://github.com/MittalAshish/libqnio.git
>>
>> Signed-off-by: Ashish Mittal <ashish.mittal@veritas.com>
>> ---
>> v6 changelog:
>> (1) Added iotests for VxHS block device.
>>
>>  tests/qemu-iotests/common        |  6 ++++++
>>  tests/qemu-iotests/common.config | 13 +++++++++++++
>>  tests/qemu-iotests/common.filter |  1 +
>>  tests/qemu-iotests/common.rc     | 19 +++++++++++++++++++
>>  4 files changed, 39 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
>> index d60ea2c..41430d8 100644
>> --- a/tests/qemu-iotests/common
>> +++ b/tests/qemu-iotests/common
>
> When using raw format, I was able to run the test successfully for all
> supported test cases (26 of them).
>
> With qcow2, they fail - but not the fault of this patch, I think; but
> rather, the fault of the test server.  Can qnio_server be modified so that
> it does not work on just raw files?
>
>

VxHS supports and uses only the raw format.

>
>> @@ -158,6 +158,7 @@ check options
>>      -nfs                test nfs
>>      -archipelago        test archipelago
>>      -luks               test luks
>> +    -vxhs               test vxhs
>>      -xdiff              graphical mode diff
>>      -nocache            use O_DIRECT on backing file
>>      -misalign           misalign memory allocations
>> @@ -261,6 +262,11 @@ testlist options
>>              xpand=false
>>              ;;
>>
>> +        -vxhs)
>> +            IMGPROTO=vxhs
>> +            xpand=false
>> +            ;;
>> +
>>          -ssh)
>>              IMGPROTO=ssh
>>              xpand=false
>> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
>> index f6384fb..c7a80c0 100644
>> --- a/tests/qemu-iotests/common.config
>> +++ b/tests/qemu-iotests/common.config
>> @@ -105,6 +105,10 @@ if [ -z "$QEMU_NBD_PROG" ]; then
>>      export QEMU_NBD_PROG="`set_prog_path qemu-nbd`"
>>  fi
>>
>> +if [ -z "$QEMU_VXHS_PROG" ]; then
>> +    export QEMU_VXHS_PROG="`set_prog_path qnio_server /usr/local/bin`"
>> +fi
>> +
>>  _qemu_wrapper()
>>  {
>>      (
>> @@ -156,10 +160,19 @@ _qemu_nbd_wrapper()
>>      )
>>  }
>>
>> +_qemu_vxhs_wrapper()
>> +{
>> +    (
>> +        echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
>> +        exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
>> +    )
>> +}
>> +
>>  export QEMU=_qemu_wrapper
>>  export QEMU_IMG=_qemu_img_wrapper
>>  export QEMU_IO=_qemu_io_wrapper
>>  export QEMU_NBD=_qemu_nbd_wrapper
>> +export QEMU_VXHS=_qemu_vxhs_wrapper
>>
>>  QEMU_IMG_EXTRA_ARGS=
>>  if [ "$IMGOPTSSYNTAX" = "true" ]; then
>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
>> index 240ed06..a8a4d0e 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -123,6 +123,7 @@ _filter_img_info()
>>          -e "s#$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$IMGFMT#IMGFMT#g" \
>>          -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
>> +        -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
>>          -e "/encrypted: yes/d" \
>>          -e "/cluster_size: [0-9]\\+/d" \
>>          -e "/table_size: [0-9]\\+/d" \
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index 3213765..06a3164 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -89,6 +89,9 @@ else
>>          TEST_IMG=$TEST_DIR/t.$IMGFMT
>>      elif [ "$IMGPROTO" = "archipelago" ]; then
>>          TEST_IMG="archipelago:at.$IMGFMT"
>> +    elif [ "$IMGPROTO" = "vxhs" ]; then
>> +        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
>> +        TEST_IMG="vxhs://127.0.0.1:9999/t.$IMGFMT"
>>      else
>>          TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
>>      fi
>> @@ -175,6 +178,12 @@ _make_test_img()
>>          eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IMG_FILE &"
>>          sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
>>      fi
>> +
>> +    # Start QNIO server on image directory for vxhs protocol
>> +    if [ $IMGPROTO = "vxhs" ]; then
>> +        eval "$QEMU_VXHS -d  $TEST_DIR &"
>> +        sleep 1 # Wait for server to come up.
>> +    fi
>>  }
>>
>>  _rm_test_img()
>> @@ -201,6 +210,16 @@ _cleanup_test_img()
>>              fi
>>              rm -f "$TEST_IMG_FILE"
>>              ;;
>> +        vxhs)
>> +            if [ -f "${TEST_DIR}/qemu-vxhs.pid" ]; then
>> +                local QEMU_VXHS_PID
>> +                read QEMU_VXHS_PID < "${TEST_DIR}/qemu-vxhs.pid"
>> +                kill ${QEMU_VXHS_PID} >/dev/null 2>&1
>> +                rm -f "${TEST_DIR}/qemu-vxhs.pid"
>> +            fi
>> +            rm -f "$TEST_IMG_FILE"
>> +            ;;
>> +
>>          file)
>>              _rm_test_img "$TEST_DIR/t.$IMGFMT"
>>              _rm_test_img "$TEST_DIR/t.$IMGFMT.orig"
>> --
>> 1.8.3.1
>>
