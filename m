Received: from eggs.gnu.org ([2001:4830:134:3::10]:53293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cdhpl-00068E-1C
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cdhpj-0006Mw-L7
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:28:13 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cdhpj-0006Mj-EC
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:28:11 -0500
Received: by mail-it0-x243.google.com with SMTP id 203so6389991ith.2
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:28:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170214181217.GS27752@localhost.localdomain>
References: <1478566785-4002-1-git-send-email-ashish.mittal@veritas.com>
	<1478566785-4002-3-git-send-email-ashish.mittal@veritas.com>
	<20170214181217.GS27752@localhost.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Tue, 14 Feb 2017 10:28:10 -0800
Message-ID: <CAAo6VWNO_evUWkA56HU9nUFfxi2Ocf=M-GRotP40rzAAJexYHQ@mail.gmail.com>
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

On Tue, Feb 14, 2017 at 10:12 AM, Jeff Cody <jcody@redhat.com> wrote:
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
>
> [...]
>
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
>
> So I spoke too soon about tests passing, but it is not really your fault :)
>
> After rebasing to master, there is a new test 174 that now hangs (and hangs
> for nbd, as well).  This is because the test is piping the results of
> _make_test_image to sed to filter it.
>
> This line should redirect stdout to /dev/null, so that the pipe does not
> need to wait until process completion:
>
>     eval "$QEMU_VXHS -d  $TEST_DIR > /dev/null &"
>
>

Will make this change in the next series. Thanks again!
