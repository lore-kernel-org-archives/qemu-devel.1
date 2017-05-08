Received: from eggs.gnu.org ([2001:4830:134:3::10]:58080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7moJ-0000OS-4V
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7moI-0000BS-9p
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:51:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-22-f4bug@amsat.org> <87y3u78uks.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15538fd9-803a-4b7d-45f2-c3153fbcfe20@amsat.org>
Date: Mon, 8 May 2017 14:50:51 -0300
MIME-Version: 1.0
In-Reply-To: <87y3u78uks.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 21/23] docker: fix powerpc debian/stable
 dependencies problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Aurelien Jarno <aurel32@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Vagrant Cascadian <vagrant@debian.org>, Michael Tokarev <mjt@tls.msk.ru>

On 05/08/2017 08:19 AM, Alex Bennée wrote:
>
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/dockerfiles/debian-powerpc-cross.docker | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
>> index 9107ebc2d3..d6e4d1e977 100644
>> --- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
>> @@ -12,6 +12,13 @@ RUN dpkg --add-architecture powerpc && \
>>      DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
>>          crossbuild-essential-powerpc
>>
>> +# <kludge> to fix "following packages have unmet dependencies" ...
>> +RUN apt-get install -y --no-install-recommends equivs pkg-config && \
>> +    apt-fake install pkg-config:powerpc=0.28-1.1-fake && \
>> +    ln -s pkg-config /usr/bin/powerpc-linux-gnu-pkg-config
>> +ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
>> +# </kludge>
>> +
>>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-
>
> Given the image needs these package hacks it is probably best folded
> into the commit adding the target.

Ok, will squash with the "ADD debian-apt-fake.sh 
/usr/local/bin/apt-fake" line.

> --
> Alex Bennée
>
