Received: from eggs.gnu.org ([2001:4830:134:3::10]:50731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ceCU0-0006nH-N6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ceCTz-00060g-9F
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:11:48 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1ceCTz-00060Y-4P
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:11:47 -0500
Received: by mail-it0-x242.google.com with SMTP id f200so1725333itf.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 19:11:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170213144356.GM10361@stefanha-x1.localdomain>
References: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
	<1486527494-3387-2-git-send-email-Ashish.Mittal@veritas.com>
	<20170213144356.GM10361@stefanha-x1.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Wed, 15 Feb 2017 19:11:45 -0800
Message-ID: <CAAo6VWOZewup4nwLvQJCs-6wNo5sB6yW8-QZ-Eh-_OMYrgJ6cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 2/2] block/vxhs.c: Add qemu-iotests for
 new block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>

Sorry, pressed the "send" button instead of "expand text" on the
previous email ...

On Mon, Feb 13, 2017 at 6:43 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Feb 07, 2017 at 08:18:14PM -0800, Ashish Mittal wrote:
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
>
> Did you test this with /usr/local/bin/qnio_server?
>
> I think it will evaluate to QEMU_VXHS_PROG=/usr/local/bin when qnio_server
> isn't found in PATH.  You probably wanted /usr/local/bin/qnio_server instead.
>
> I suggest dropping the second argument completely and letting the user set PATH
> themselves.  No existing set_prog_path caller uses the second argument.
>

You're right. Will drop the second argument.

> # $1 = prog to look for, $2* = default pathnames if not found in $PATH
> set_prog_path()
> {
>     p=`command -v $1 2> /dev/null`
>     if [ -n "$p" -a -x "$p" ]; then
>         echo $p
>         return 0
>     fi
>     p=$1
>
>     shift
>     for f; do
>         if [ -x $f ]; then
>             echo $f
>             return 0
>         fi
>     done
>
>     echo ""
>     return 1
> }
>
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
>
> This is a pre-existing problem and you don't need to fix it now:
>
> We should replace sleep 1 with a function that probes the TCP port until the
> connection can be established or a timeout is reached.  The netcat (nc) utility
> is often used for this.
>
> sleep 1 is not reliable and may fail on a heavily loaded machine like the
> Travis-CI build machines that are used.

Will skip this one for now.

Thanks,
Ashish
