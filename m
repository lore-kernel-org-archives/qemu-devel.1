Received: from eggs.gnu.org ([2001:4830:134:3::10]:52792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYyLl-0002ji-Sw
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYyLk-0007SM-GQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:10:13 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180109184523.3d0aab51.cohuck@redhat.com>
References: <cover.1513790494.git.alistair.francis@xilinx.com>
	<3f49c0ff601f27534d4536c87c00d01c233e067f.1513790495.git.alistair.francis@xilinx.com>
	<20180109184523.3d0aab51.cohuck@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 9 Jan 2018 10:09:40 -0800
Message-ID: <CAKmqyKN9HVzOfRK57keymYHe1k31sQE1WMTEUGVgawkOxug2RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 21/29] hw/s390x: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org

On Tue, Jan 9, 2018 at 9:45 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Wed, 20 Dec 2017 09:24:41 -0800
> Alistair Francis <alistair.francis@xilinx.com> wrote:
>
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and then
>> compiler issues where manually fixed.
>>
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>     {} +
>>
>> Some lines where then manually tweaked to pass checkpatch.
>>
>> One fprintf(stderr, was manually converted to a
>> qemu_log_mask(LOG_GUEST_ERROR,
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>> V3:
>>  - Use a qemu_log_mask(LOG_GUEST_ERROR,
>> V2:
>>  - Split hw patch into individual directories
>>
>>  hw/s390x/virtio-ccw.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index 38f6a8afc9..3d8f26949b 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -426,8 +426,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>                   * passes us zeroes for those we don't support.
>>                   */
>>                  if (features.features) {
>> -                    fprintf(stderr, "Guest bug: features[%i]=%x (expected 0)\n",
>> -                            features.index, features.features);
>> +                    qemu_log_mask(LOG_GUEST_ERROR,
>> +                                  "Guest bug: features[%i]=%x (expected 0)",
>> +                                  features.index, features.features);
>>                      /* XXX: do a unit check here? */
>>                  }
>>              }
>
> I'll queue this to s390-next so this doesn't get lost.
>
> I'll also tweak the commit message, as nothing is converted to
> error_report().

Thanks!

Alistair
