Received: from eggs.gnu.org ([2001:4830:134:3::10]:58239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAq6k-0000dg-RH
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAq6g-0003yX-R8
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:58:42 -0400
Received: from [59.151.112.132] (port=1623 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAq6f-0003x4-4u
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:58:38 -0400
References: <22f56a33f9774a678c72dc5c0920a5c562cc6ea2.1494937835.git.maozy.fnst@cn.fujitsu.com>
	<8737c4es6a.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <ef31eebc-3af3-a5e3-5fbf-af7e971af14d@cn.fujitsu.com>
Date: Wed, 17 May 2017 11:58:06 +0800
MIME-Version: 1.0
In-Reply-To: <8737c4es6a.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] net/rocker: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, jiri@resnulli.us, f4bug@amsat.org

Hi, Markus

On 05/16/2017 11:29 PM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> The rocker device still implements the old PCIDeviceClass .init()
>> instead of the new .realize(). All devices need to be converted to
>> .realize().
>
> Thanks for chipping in!
>
>> .init() reports errors with fprintf() and return 0 on success, negative
>> number on failure. Meanwhile, when -device rocker fails, it first report
>> a specific error, then a generic one, like this:
>>
>>     $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=qemu-rocker
>>     rocker: name too long; please shorten to at most 9 chars
>>     qemu-system-x86_64: -device rocker,name=qemu-rocker: Device initialization failed
>>
>> Now, convert it to .realize() that passes errors to its callers via its
>> errp argument. Also avoid the superfluous second error message.
>
> Recommend to show the error message after your patch here:
>
>       qemu-system-x86_64: -device rocker,name=qemu-rocker: rocker: name too long; please shorten to at most 9 chars

Thanks, I think I got it.

>
> Not least because that makes it blatantly obvious that keeping the
> "rocker: " is not a good idea :)

Actually, I was always curious about why there are 2 "rocker" strings
in the report, it's superfluous. But in order to keep a consistent log
format, so inherited the original style.

Will remove it in the next version.

>
>> Cc: jiri@resnulli.us
>> Cc: jasowang@redhat.com
>> Cc: f4bug@amsat.org
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  hw/net/rocker/rocker.c | 35 +++++++++++++++++------------------
>>  1 file changed, 17 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
>> index 6e70fdd..c446cda 100644
>> --- a/hw/net/rocker/rocker.c
>> +++ b/hw/net/rocker/rocker.c
>> @@ -1252,20 +1252,18 @@ rollback:
>>      return err;
>>  }
>>
>> -static int rocker_msix_init(Rocker *r)
>> +static int rocker_msix_init(Rocker *r, Error **errp)
>>  {
>>      PCIDevice *dev = PCI_DEVICE(r);
>>      int err;
>> -    Error *local_err = NULL;
>>
>>      err = msix_init(dev, ROCKER_MSIX_VEC_COUNT(r->fp_ports),
>>                      &r->msix_bar,
>>                      ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_TABLE_OFFSET,
>>                      &r->msix_bar,
>>                      ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
>> -                    0, &local_err);
>> +                    0, errp);
>>      if (err) {
>> -        error_report_err(local_err);
>>          return err;
>>      }
>>
>> @@ -1301,7 +1299,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
>>      return NULL;
>>  }
>>
>> -static int pci_rocker_init(PCIDevice *dev)
>> +static void pci_rocker_realize(PCIDevice *dev, Error **errp)
>>  {
>>      Rocker *r = to_rocker(dev);
>>      const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
>> @@ -1315,7 +1313,7 @@ static int pci_rocker_init(PCIDevice *dev)
>>
>>      for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
>>          if (!r->worlds[i]) {
>> -            err = -ENOMEM;
>> +            error_setg(errp, "rocker: memory allocation for worlds failed");
>
> r->worlds[i] is null when of_dpa_world_alloc() returns null.  It's a
> wrapper around world_alloc(), which returns null only when g_malloc()
> does.  It doesn't.  Please remove the dead error handling.  Ideally in a
> separate cleanup patch before this one, to facilitate review.
>

Thanks very much for your detailed explanation.

After reading g_malloc0(), I am aware of this: g_malloc0(size_t size) 
returns null only when size is 0. But it is a wrapper around
g_malloc0_n(1, size) that ignore the fact that g_malloc0() of 0 bytes
returns null. So it doesn't return null. Am I right?


> Recommend to drop the "rocker: " prefix.  Same for all the other error
> messages.
>

Thanks, will dorp it entirely.

>>              goto err_world_alloc;
>>          }
>>      }
>> @@ -1326,10 +1324,9 @@ static int pci_rocker_init(PCIDevice *dev)
>>
>>      r->world_dflt = rocker_world_type_by_name(r, r->world_name);
>>      if (!r->world_dflt) {
>> -        fprintf(stderr,
>> -                "rocker: requested world \"%s\" does not exist\n",
>> +        error_setg(errp,
>> +                "rocker: invalid argument, requested world %s does not exist",
>>                  r->world_name);
>> -        err = -EINVAL;
>>          goto err_world_type_by_name;
>>      }
>>
>> @@ -1349,7 +1346,7 @@ static int pci_rocker_init(PCIDevice *dev)
>>
>>      /* MSI-X init */
>>
>> -    err = rocker_msix_init(r);
>> +    err = rocker_msix_init(r, errp);
>>      if (err) {
>>          goto err_msix_init;
>>      }
>> @@ -1361,7 +1358,7 @@ static int pci_rocker_init(PCIDevice *dev)
>>      }
>>
>>      if (rocker_find(r->name)) {
>> -        err = -EEXIST;
>> +        error_setg(errp, "rocker: %s already exists", r->name);
>>          goto err_duplicate;
>>      }
>>
>> @@ -1375,10 +1372,10 @@ static int pci_rocker_init(PCIDevice *dev)
>>  #define ROCKER_IFNAMSIZ 16
>>  #define MAX_ROCKER_NAME_LEN  (ROCKER_IFNAMSIZ - 1 - 3 - 3)
>>      if (strlen(r->name) > MAX_ROCKER_NAME_LEN) {
>> -        fprintf(stderr,
>> -                "rocker: name too long; please shorten to at most %d chars\n",
>> +        error_setg(errp,
>> +                "rocker: name too long; please shorten to at most %d chars",
>>                  MAX_ROCKER_NAME_LEN);
>> -        return -EINVAL;
>> +        goto err_name_too_long;
>
> Is this a bug fix?

Before the patch, it will return a negative value when the name more
than 9 chars. But it doesn't free the memory of world and msix that
has allocated previously.

After the patch, I think the cleanup is more entire. doesn't it?

>
>>      }
>>
>>      if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) == 0) {
>> @@ -1397,6 +1394,7 @@ static int pci_rocker_init(PCIDevice *dev)
>>
>>      r->rings = g_new(DescRing *, rocker_pci_ring_count(r));
>>      if (!r->rings) {
>> +        error_setg(errp, "rocker: memory allocation for rings failed");
>>          goto err_rings_alloc;
>>      }
>
> g_new() can't fail.  Please remove the dead error handling.

Thanks, will drop it.

>
>>
>> @@ -1410,11 +1408,11 @@ static int pci_rocker_init(PCIDevice *dev)
>>       * .....
>>       */
>>
>> -    err = -ENOMEM;
>>      for (i = 0; i < rocker_pci_ring_count(r); i++) {
>>          DescRing *ring = desc_ring_alloc(r, i);
>>
>>          if (!ring) {
>> +            error_setg(errp, "rocker: memory allocation for ring failed");
>>              goto err_ring_alloc;
>>          }
>>
>
> desc_ring_alloc() returns null only when g_new0() does.  It doesn't.
> Please remove the dead error handling here and in desc_ring_alloc().
>

I got it, will remove it in the next version.
Thanks

>> @@ -1438,6 +1436,7 @@ static int pci_rocker_init(PCIDevice *dev)
>>                            i, &r->fp_ports_peers[i]);
>>
>>          if (!port) {
>> +            error_setg(errp, "rocker: memory allocation for port failed");
>>              goto err_port_alloc;
>>          }
>>
>
> Likewise for fp_port_alloc().
>
> I recommend you search all of rocker/ for similarly dead error checking
> after g_malloc() & friends.

I'll search and fix similar error checking.

>
>> @@ -1447,7 +1446,7 @@ static int pci_rocker_init(PCIDevice *dev)
[...]

Thanks for your quick review:), will do the fix right away.

Mao
