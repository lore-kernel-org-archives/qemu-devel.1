Received: from eggs.gnu.org ([2001:4830:134:3::10]:48451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG2Am-0003ku-Qm
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG2Ai-00018u-BB
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:56:52 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:44394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG2Ai-00018e-5i
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:56:48 -0400
Received: by mail-qt0-x236.google.com with SMTP id d3-v6so40752316qtp.11
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 05:56:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-37-git-send-email-mst@redhat.com>
	<87o9hq8hcs.fsf@secure.laptop>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2e2101dd-65be-efb0-c774-28793bee1436@amsat.org>
Date: Tue, 8 May 2018 09:56:43 -0300
MIME-Version: 1.0
In-Reply-To: <87o9hq8hcs.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 36/67] migration: add include directory
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 05/08/2018 09:25 AM, Juan Quintela wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> This way they are easier to find using standard rules.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Nack.
> 
> This are _internal_ files, that shouldn't be used anywere elese.
> 
> Except .... that we need them to write tests.  We only have two scopes
> on qemu:
> - internal: only for the subsystem we are at in
> - pubilc: they can be used everywhere
> 
> So, tests came in a strange class here, because they need internal
> implementation, but they are not in the proper directory due to the way
> we do tests.
> 
> I *think* that using complete paths is the only reasonable way of doing
> this.

I hit the same issue with SD tests.

The current scheme is confuse but works fine:

tests/test-vmstate.c:30:#include "migration/qemu-file-types.h"
tests/test-vmstate.c:32:#include "../migration/qemu-file-channel.h"

Michael, what about keeping those includes internal ("only for the
subsystem we are at in") and adding complete paths in
tests/Makefile.include?
Such:

tests/test-vmstate.o: QEMU_CFLAGS += -I$(SRC_PATH)/migration
