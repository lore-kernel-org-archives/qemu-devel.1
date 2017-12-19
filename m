Received: from eggs.gnu.org ([2001:4830:134:3::10]:50566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRKkv-0000Fm-BY
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRKks-0004P0-Dv
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:28:37 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRKks-0004OC-42
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:28:34 -0500
References: <20171219115447.17948-1-laurent@vivier.eu>
	<CAAdtpL5LUMb33mBvEFcfbj=_HrhzsuadkokrxosftJ1hiLS3fA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fb5c727f-884e-c8f2-591f-9142954383dd@vivier.eu>
Date: Tue, 19 Dec 2017 17:28:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5LUMb33mBvEFcfbj=_HrhzsuadkokrxosftJ1hiLS3fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Split adb.c into adb.c,
 adb-mouse.c and adb-kbd.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Le 19/12/2017 à 16:26, Philippe Mathieu-Daudé a écrit :
> Hi Laurent,
> 
> On Tue, Dec 19, 2017 at 8:54 AM, Laurent Vivier <laurent@vivier.eu> wrote:
>> It makes the code clearer to separate the bus implementation
>> from the devices one.
>>
>> Remove ADB_DPRINTF() from adb.c instead of adding it to new files.
>> Some minor changes to make checkpatch.pl happy.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  hw/input/Makefile.objs |   2 +-
>>  hw/input/adb-kbd.c     | 395 +++++++++++++++++++++++++++++++
>>  hw/input/adb-mouse.c   | 250 ++++++++++++++++++++
>>  hw/input/adb.c         | 621 +------------------------------------------------
>>  include/hw/input/adb.h |  26 +++
>>  5 files changed, 673 insertions(+), 621 deletions(-)
>>  create mode 100644 hw/input/adb-kbd.c
>>  create mode 100644 hw/input/adb-mouse.c
>>
...
>> +
>> +/* ADB commands */
>> +
>> +#define ADB_BUSRESET            0x00
>> +#define ADB_FLUSH               0x01
>> +#define ADB_WRITEREG            0x08
>> +#define ADB_READREG             0x0c
>> +
>> +/* ADB device commands */
>> +
>> +#define ADB_CMD_SELF_TEST               0xff
>> +#define ADB_CMD_CHANGE_ID               0xfe
>> +#define ADB_CMD_CHANGE_ID_AND_ACT       0xfd
>> +#define ADB_CMD_CHANGE_ID_AND_ENABLE    0x00
>> +
>> +/* ADB default device IDs (upper 4 bits of ADB command byte) */
>> +
>> +#define ADB_DEVID_DONGLE      1
>> +#define ADB_DEVID_KEYBOARD    2
>> +#define ADB_DEVID_MOUSE       3
>> +#define ADB_DEVID_TABLET      4
>> +#define ADB_DEVID_MODEM       5
>> +#define ADB_DEVID_MISC        7
> 
> Is ADB the protocol used out of adb*.c?
> Personally I prefer not expose those protocol defines if not needed,
> so I'd add them to hw/input/adb-protocol.h (or to match the other
> includes, hw/input/adb-internal.h).
> 
> regardless this comment:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> +
>>  typedef struct ADBDevice ADBDevice;
>>
>>  /* buf = NULL means polling */
>> @@ -77,6 +101,8 @@ struct ADBBusState {
>>      int poll_index;
>>  };
>>
>> +extern const VMStateDescription vmstate_adb_device;
> 
> If you choose to add hw/input/adb-internal.h, this extern can go there.
> 
>> +
>>  int adb_request(ADBBusState *s, uint8_t *buf_out,
>>                  const uint8_t *buf, int len);
>>  int adb_poll(ADBBusState *s, uint8_t *buf_out, uint16_t poll_mask);
>> --
>> 2.14.3
>>


I agree with you, I'm going to add an new include, hw/input/adb-internal.h

Thanks,
Laurent
