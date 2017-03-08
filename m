Received: from eggs.gnu.org ([2001:4830:134:3::10]:56499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1cljIi-0000V9-9M
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1cljIe-0001gG-Po
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:39:16 -0500
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com
	([104.47.36.59]:53071
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1cljIe-0001fy-GP
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:39:12 -0500
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900638368.27090.17089251247635148558.stgit@brijesh-build-machine>
	<20170308211302.GO4694@thinpad.lan.raisama.net>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <937f9576-b227-e1a9-34cd-50d67f07d08c@amd.com>
Date: Wed, 8 Mar 2017 15:39:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170308211302.GO4694@thinpad.lan.raisama.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 11/20] sev: add LAUNCH_START command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: brijesh.singh@amd.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com



On 03/08/2017 03:13 PM, Eduardo Habkost wrote:
> On Wed, Mar 08, 2017 at 03:53:03PM -0500, Brijesh Singh wrote:
>> The command is used to bootstrap SEV guest from unencrypted boot images.
>> The command creates a new VM encryption key (VEK) using guest owner's public
>> DH certificate, and security policy and session parameters. The encryption
>> key created during launch start process will be used for encryption the boot
>> images (such as BIOS).
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>
> These descriptions of what the commands do are very useful. I
> suggest including something similar (but more generic and not
> SEV-specific?) as the documentation of the kvm_memcrypt_*() API
> functions, as it is not clear what each kvm_memcrypt_*() function
> is supposed to do.
>

Thanks for quick feedback. I will include some generic documentation of the kvm_memcrypt_*() APIs.

-Brijesh

>
>> ---
>>  include/sysemu/sev.h |    1 +
>>  kvm-all.c            |    1 +
>>  sev.c                |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 57 insertions(+)
>>
>> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
>> index dbc3c6c..747fe87 100644
>> --- a/include/sysemu/sev.h
>> +++ b/include/sysemu/sev.h
>> @@ -86,6 +86,7 @@ typedef struct SEVState SEVState;
>>  bool sev_enabled(void);
>>  void *sev_guest_init(const char *keyid);
>>  void sev_set_debug_ops(void *handle, MemoryRegion *mr);
>> +int sev_create_launch_context(void *handle);
>>
>>  #endif
>>
>> diff --git a/kvm-all.c b/kvm-all.c
>> index 1fa6413..a13d62f 100644
>> --- a/kvm-all.c
>> +++ b/kvm-all.c
>> @@ -1826,6 +1826,7 @@ static int kvm_init(MachineState *ms)
>>                  goto err;
>>              }
>>              kvm_state->memcrypt_debug_ops = sev_set_debug_ops;
>> +            kvm_state->create_launch_context = sev_create_launch_context;
>>              g_free(id);
>>          }
>>      }
>> diff --git a/sev.c b/sev.c
>> index 3e02453..4b3f39a 100644
>> --- a/sev.c
>> +++ b/sev.c
>> @@ -148,6 +148,55 @@ static const TypeInfo qsev_launch_info = {
>>  };
>>
>>  static int
>> +sev_ioctl(int cmd, void *data, int *error)
>> +{
>> +    int r;
>> +    struct kvm_sev_cmd input;
>> +
>> +    input.id = cmd;
>> +    input.sev_fd = sev_fd;
>> +    input.data = (__u64)data;
>> +
>> +    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &input);
>> +    *error = input.error;
>> +    return r;
>> +}
>> +
>> +static int
>> +sev_launch_start(SEVState *s)
>> +{
>> +    int ret = 1;
>> +    Object *obj;
>> +    int fw_error;
>> +    struct kvm_sev_launch_start *start;
>> +
>> +    if (!s) {
>> +        return 1;
>> +    }
>> +
>> +    start = g_malloc0(sizeof(*start));
>> +    if (!start) {
>> +        return 1;
>> +    }
>> +
>> +    obj = object_property_get_link(OBJECT(s->sev_info), "launch", &error_abort);
>> +    if (!obj) {
>> +        goto err;
>> +    }
>> +
>> +    ret = sev_ioctl(KVM_SEV_LAUNCH_START, start, &fw_error);
>> +    if (ret < 0) {
>> +        fprintf(stderr, "failed LAUNCH_START %d (%#x)\n", ret, fw_error);
>> +        goto err;
>> +    }
>> +
>> +    DPRINTF("SEV: LAUNCH_START\n");
>> +err:
>> +    g_free(start);
>> +    return ret;
>> +}
>> +
>> +static int
>>  sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
>>  {
>>      return 0;
>> @@ -200,6 +249,12 @@ err:
>>      return NULL;
>>  }
>>
>> +int
>> +sev_create_launch_context(void *handle)
>> +{
>> +    return sev_launch_start((SEVState *)handle);
>> +}
>> +
>>  void
>>  sev_set_debug_ops(void *handle, MemoryRegion *mr)
>>  {
>>
>
