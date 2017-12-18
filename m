Received: from eggs.gnu.org ([2001:4830:134:3::10]:38628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQwtO-0003Af-GN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQwtN-0003qG-NX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:59:46 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <3c50449d-870a-6347-74ba-cde968322891@amsat.org>
References: <20171217204912.12420-1-f4bug@amsat.org>
	<20171217204912.12420-3-f4bug@amsat.org>
	<d0ab7c99-1174-1629-b8ac-87961f17fc4c@redhat.com>
	<3c50449d-870a-6347-74ba-cde968322891@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Dec 2017 11:59:44 -0300
Message-ID: <CAAdtpL5hGHfH5Qd5qtvK==aTJ5FMjd61OK0BkpY920LBuMqm7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/pci-host/piix: QOM'ify the IGD
 Passthrough host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>

[...]
>>>   -static int host_pci_config_read(int pos, int len, uint32_t *val)
>>> +static void host_pci_config_read(int pos, int len, uint32_t *val,
>>> Error **errp)
>>>   {
>>>       char path[PATH_MAX];
>>>       int config_fd;
>>> @@ -812,19 +812,19 @@ static int host_pci_config_read(int pos, int
>>> len, uint32_t *val)
>>>       /* Access real host bridge. */
>>>       int rc = snprintf(path, size,
>>> "/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
>>>                         0, 0, 0, 0, "config");
>>> -    int ret = 0;
>>>         if (rc >= size || rc < 0) {
>>> -        return -ENODEV;
>>> +        error_setg(&error_abort, "Invalid PCI device");
>>
>> I think a return statement is missing here.
>
> Well, error_setg(&error_abort) will never return, however checking the
> documentation again I noticed I forgot these recommendations:
>
>  * Please don't error_setg(&error_fatal, ...), use error_report() and
>  * exit(), because that's more obvious.
>  * Likewise, don't error_setg(&error_abort, ...), use assert().
>
> abort() might be OK but a bit harsh, so I'll use error_report() + exit()
> here.

Actually g_strdup_printf() is cleaner.

>>>       }
>>>         config_fd = open(path, O_RDWR);
>>>       if (config_fd < 0) {
>>> -        return -ENODEV;
>>> +        error_setg_errno(errp, errno, "Failed to open: %s", path);
>>> +        return;
>>>       }
>>>         if (lseek(config_fd, pos, SEEK_SET) != pos) {
>>> -        ret = -errno;
>>> +        error_setg_errno(errp, errno, "Failed to seek: %s", path);
>>>           goto out;
>>>       }
>>>   @@ -832,32 +832,31 @@ static int host_pci_config_read(int pos, int
>>> len, uint32_t *val)
>>>           rc = read(config_fd, (uint8_t *)val, len);
>>>       } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>>>       if (rc != len) {
>>> -        ret = -errno;
>>> +        error_setg_errno(errp, errno, "Failed to read: %s", path);
>>>       }
>>>     out:
>>>       close(config_fd);
>>> -    return ret;
>>>   }
[...]
