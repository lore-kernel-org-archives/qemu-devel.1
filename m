Received: from eggs.gnu.org ([2001:4830:134:3::10]:60179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPpAr-0000St-Gl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPpAl-00066I-OT
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:05:25 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fPpAl-00065P-Ht
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:05:19 -0400
Received: by mail-wr0-x244.google.com with SMTP id w7-v6so31300352wrn.6
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 06:05:19 -0700 (PDT)
References: <20180502002143.30624-1-f4bug@amsat.org>
	<082d9daf-d430-0917-f71e-a96d7735160e@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <082d9daf-d430-0917-f71e-a96d7735160e@amsat.org>
Date: Mon, 04 Jun 2018 14:05:17 +0100
Message-ID: <87muwad7n6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: add debian/tricore image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex, ping for review ;)

queued, thanks.

>
> On 05/01/2018 09:21 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> TriCore binutils is built from Bastian Koppelmann repository.
>>
>> Note: There is no TriCore compiler in this image (only assembler/linker).
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> See http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg00074.html
>>
>> $ docker images --format "{{.Repository}}:{{.Tag}} {{.Size}}"
>> qemu:debian-tricore-cross 323MB
>>
>>  .../dockerfiles/debian-tricore-cross.docker   | 35 +++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/debian-tricore-cross.docker
>>
>> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/test=
s/docker/dockerfiles/debian-tricore-cross.docker
>> new file mode 100644
>> index 0000000000..f71ac3eb47
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
>> @@ -0,0 +1,35 @@
>> +#
>> +# Docker TriCore cross-compiler target
>> +#
>> +# This docker target builds on the debian Stretch base image.
>> +#
>> +# Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +FROM debian:stretch-slim
>> +
>> +MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> +
>> +# Install common build utilities
>> +RUN apt-get update && \
>> +    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy eatmydata && \
>> +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>> +    apt-get install -y --no-install-recommends \
>> +        automake \
>> +        bison \
>> +        build-essential \
>> +        ca-certificates \
>> +        flex \
>> +        git
>> +
>> +RUN git clone --single-branch \
>> +        https://github.com/bkoppelmann/tricore-binutils.git \
>> +        /usr/src/binutils && \
>> +    cd /usr/src/binutils && chmod +x missing && \
>> +    CFLAGS=3D-w ./configure --prefix=3D/usr --disable-nls --target=3Dtr=
icore && \
>> +    make && make install && \
>> +    rm -rf /usr/src/binutils
>> +
>> +# Specify the cross prefix for this image (see tests/docker/common.rc)
>> +ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dtricore-
>>


--
Alex Benn=C3=A9e
