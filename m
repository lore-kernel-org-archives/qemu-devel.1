Received: from eggs.gnu.org ([209.51.188.92]:38175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h2LRW-00073w-EI
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h2LRU-00043v-Rb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:46:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h2LRU-00042R-Iu
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:46:04 -0500
Date: Fri, 8 Mar 2019 11:45:51 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Message-ID: <20190308194551.GB20066@heatpipe>
References: <20190307072215.9104-1-elena.ufimtseva@oracle.com>
	<20190307103952.GC2811@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307103952.GC2811@work-vm>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 21/37] multi-process:
 QMP/HMP commands to add a device to the remote process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, berrange@redhat.com, armbru@redhat.com, eblake@redhat.com

On Thu, Mar 07, 2019 at 10:39:54AM +0000, Dr. David Alan Gilbert wrote:
> * elena.ufimtseva@oracle.com (elena.ufimtseva@oracle.com) wrote:
> > From: Jagannathan Raman <jag.raman@oracle.com>
> > 
> > Adds rdevice_add QMP & HMP commands to hotplug device to a remote device.
> > 
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > ---
> >  hmp-commands.hx         | 14 ++++++++
> >  hmp.h                   |  1 +
> >  hw/proxy/monitor.c      | 92 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/io/proxy-link.h |  2 ++
> >  include/monitor/qdev.h  |  4 +++
> >  monitor.c               |  5 +++
> >  qapi/misc.json          | 22 ++++++++++++
> >  remote/remote-main.c    | 48 ++++++++++++++++++++++++++
> >  8 files changed, 188 insertions(+)
> > 
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index fb3c8ba..7e8e8ab 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -727,6 +727,20 @@ ETEXI
> >  
> >  #if defined(CONFIG_MPQEMU)
> >      {
> > +        .name       = "rdevice_add",
> > +        .args_type  = "rdev_id:s,driver:s,id:s,drive:s,bus:s",
> > +        .params     = "rdev_id driver id drive bus",
> > +        .help       = "add device to remote proc, like -rdevice on the command line",
> > +        .cmd        = hmp_rdevice_add,
> > +    },
> > +
> > +STEXI
> > +@item rdevice_add @var{config}
> > +@findex rdevice_add
> > +Add device to remote proc.
> > +ETEXI
> > +
> > +    {
> >          .name       = "remote_proc_list",
> >          .args_type  = "",
> >          .params     = "",
> > diff --git a/hmp.h b/hmp.h
> > index 0940634..355a27e 100644
> > --- a/hmp.h
> > +++ b/hmp.h
> > @@ -150,5 +150,6 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
> >  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
> >  void hmp_info_sev(Monitor *mon, const QDict *qdict);
> >  void hmp_remote_proc_list(Monitor *mon, const QDict *qdict);
> > +void hmp_rdevice_add(Monitor *mon, const QDict *qdict);
> >  
> >  #endif
> > diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
> > index 3005eec..2e2cda0 100644
> > --- a/hw/proxy/monitor.c
> > +++ b/hw/proxy/monitor.c
> > @@ -23,6 +23,7 @@
> >   */
> >  
> >  #include <sys/types.h>
> > +#include <string.h>
> >  
> >  #include "qemu/osdep.h"
> >  #include "qapi/qapi-types-block-core.h"
> > @@ -33,6 +34,13 @@
> >  #include "hw/boards.h"
> >  #include "hw/i386/pc.h"
> >  #include "hw/proxy/qemu-proxy.h"
> > +#include "qapi/qapi-commands-misc.h"
> > +#include "monitor/qdev.h"
> > +#include "qapi/qmp/qdict.h"
> > +#include "qapi/qmp/qjson.h"
> > +#include "qapi/qmp/qstring.h"
> > +#include "qapi/error.h"
> > +#include "io/proxy-link.h"
> >  
> >  /*
> >   * TODO: Is there a callback where the allocated memory for QMP could be free'd
> > @@ -87,3 +95,87 @@ void hmp_remote_proc_list(Monitor *mon, const QDict *qdict)
> >                         pdev->remote_pid, pdev->rid, id, k->command);
> >      }
> >  }
> > +
> > +static PCIProxyDev *get_proxy_device(QDict *qdict, Error **errp)
> > +{
> > +    PCMachineState *pcms = PC_MACHINE(current_machine);
> > +    PCIProxyDev *pdev = NULL;
> > +    const char *rdev_id;
> > +
> > +    if (!qdict_haskey(qdict, "rdev_id")) {
> > +        error_setg(errp, "Please specify a value for rdev_id");
> > +        return NULL;
> > +    }
> > +
> > +    rdev_id = qdict_get_str(qdict, "rdev_id");
> > +
> > +    pdev = (PCIProxyDev *)g_hash_table_lookup(pcms->remote_devs, rdev_id);
> > +    if (!pdev) {
> > +        error_setg(errp,
> > +                   "No remote device by ID %s. Use query-remote command to get remote devices",
> > +                   rdev_id);
> > +    }
> > +
> > +    return pdev;
> > +}
> > +
> > +static void rdevice_add_del(QDict *qdict, proc_cmd_t cmd, Error **errp)
> > +{
> > +    PCMachineState *pcms = PC_MACHINE(current_machine);
> > +    ProcMsg msg = {0};
> > +    PCIProxyDev *pdev = NULL;
> > +    const char *id;
> > +    QString *json;
> > +    int wait;
> > +
> > +    pdev = get_proxy_device(qdict, errp);
> > +    if (*errp) {
> > +        return;
> > +    }
> > +
> > +    qdict_del(qdict, "rdev_id");
> > +
> > +    id = qdict_get_str(qdict, "id");
> > +
> > +    json = qobject_to_json(QOBJECT(qdict));
> > +
> > +    wait = GET_REMOTE_WAIT;
> > +
> > +    msg.cmd = cmd;
> > +    msg.bytestream = 1;
> > +    msg.size = strlen(qstring_get_str(json));
> > +    msg.data2 = (uint8_t *)qstring_get_str(json);
> > +    msg.num_fds = 1;
> > +    msg.fds[0] = wait;
> > +
> > +    proxy_proc_send(pdev->proxy_link, &msg);
> > +    (void)wait_for_remote(wait);
> > +    PUT_REMOTE_WAIT(wait);
>

Hi David

Thanks for your comments.

> Can this not fail? For example what happens if the external
> process dies just about here?

We did not take care yet of these scenarios. Probably polling on the
file descriptor with a timeout will help with this.
This will be addressed in the next patchset.
> 
> > +    qstring_destroy_obj(QOBJECT(json));
> 
> All of this:
>     build some JSON
>     send it to the remote
>     wait for the response
> 
> all looks like something more generic than a device add/del - separate
> function?

Agree, that does look like it can be generalized.
> 
> > +    /* TODO: Only on success */
> > +    if (cmd == DEVICE_ADD) {
> > +        (void)g_hash_table_insert(pcms->remote_devs, (gpointer)g_strdup(id),
> > +                                  (gpointer)pdev);
> > +    }
> > +}
> > +
> > +void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp)
> > +{
> > +    rdevice_add_del(qdict, DEVICE_ADD, errp);
> > +}
> > +
> > +void hmp_rdevice_add(Monitor *mon, const QDict *qdict)
> > +{
> > +    Error *err = NULL;
> > +
> > +    /* TODO: Is it OK to modify the QDict argument from HMP? */
> > +    rdevice_add_del((QDict *)qdict, DEVICE_ADD, &err);
> > +
> > +    if (err) {
> > +        monitor_printf(mon, "rdevice_add error: %s\n",
> > +                       error_get_pretty(err));
> > +        error_free(err);
> > +    }
> > +}
> > diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
> > index 175e2f1..8781508 100644
> > --- a/include/io/proxy-link.h
> > +++ b/include/io/proxy-link.h
> > @@ -60,6 +60,7 @@ typedef struct ProxyLinkState ProxyLinkState;
> >   * BAR_READ         Reads from PCI BAR region
> >   * SET_IRQFD        Sets the IRQFD to be used to raise interrupts directly
> >   *                  from remote device
> > + * DEVICE_ADD       QMP/HMP command to hotplug device
> >   *
> >   */
> >  typedef enum {
> > @@ -70,6 +71,7 @@ typedef enum {
> >      BAR_WRITE,
> >      BAR_READ,
> >      SET_IRQFD,
> > +    DEVICE_ADD,
> >      MAX,
> >  } proc_cmd_t;
> >  
> > diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> > index 0ff3331..065701c 100644
> > --- a/include/monitor/qdev.h
> > +++ b/include/monitor/qdev.h
> > @@ -10,6 +10,10 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict);
> >  void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
> >  void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
> >  
> > +#ifdef CONFIG_MPQEMU
> > +void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp);
> > +#endif
> > +
> 
> I don't think you need to bother ifdef'ing the headers

Ah, that's right, not needed.
> 
> >  int qdev_device_help(QemuOpts *opts);
> >  DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
> >  void qdev_set_id(DeviceState *dev, const char *id);
> > diff --git a/monitor.c b/monitor.c
> > index defa129..0ad52e5 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -1155,6 +1155,11 @@ static void monitor_init_qmp_commands(void)
> >      qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
> >                           QCO_NO_OPTIONS);
> >  
> > +#ifdef CONFIG_MPQEMU
> > +    qmp_register_command(&qmp_commands, "rdevice_add", qmp_rdevice_add,
> > +                         QCO_NO_OPTIONS);
> > +#endif
> > +
> >      QTAILQ_INIT(&qmp_cap_negotiation_commands);
> >      qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
> >                           qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG);
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 8b3ca4f..28d49ea 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -1663,6 +1663,28 @@
> >    'gen': false } # so we can get the additional arguments
> >  
> >  ##
> > +# @rdevice_add:
> > +#
> > +# @rdev_id: ID of the remote device root
> > +#
> > +# @driver: the name of the new device's driver
> > +#
> > +# @bus: the device's parent bus (device tree path)
> > +#
> > +# @id: the device's ID, must be unique
> > +#
> > +# Additional arguments depend on the type.
> > +#
> > +# Add a device.
> > +#
> > +# Since: 3.0
> > +##
> > +{ 'command': 'rdevice_add',
> > +  'data': {'rdev_id': 'str', 'driver': 'str', '*bus': 'str', '*id': 'str'},
> > +  'if': 'defined(CONFIG_MPQEMU)',
> > +  'gen': false } # so we can get the additional arguments
> > +
> > +##
> >  # @device_del:
> >  #
> >  # Remove a device from a guest
> > diff --git a/remote/remote-main.c b/remote/remote-main.c
> > index 4683e7d..03c14de 100644
> > --- a/remote/remote-main.c
> > +++ b/remote/remote-main.c
> > @@ -48,6 +48,11 @@
> >  #include "exec/memattrs.h"
> >  #include "exec/address-spaces.h"
> >  #include "remote/iohub.h"
> > +#include "qapi/qmp/qjson.h"
> > +#include "qapi/qmp/qobject.h"
> > +#include "qemu/option.h"
> > +#include "qemu/config-file.h"
> > +#include "monitor/qdev.h"
> >  
> >  static ProxyLinkState *proxy_link;
> >  PCIDevice *remote_pci_dev;
> > @@ -138,6 +143,44 @@ fail:
> >      PUT_REMOTE_WAIT(wait);
> >  }
> >  
> > +static void process_device_add_msg(ProcMsg *msg)
> > +{
> > +    Error *local_err = NULL;
> > +    const char *json = (const char *)msg->data2;
> > +    int wait = msg->fds[0];
> > +    QObject *qobj = NULL;
> > +    QDict *qdict = NULL;
> > +    QemuOpts *opts = NULL;
> > +
> > +    qobj = qobject_from_json(json, &local_err);
> > +    if (local_err) {
> > +        goto fail;
> > +    }
> > +
> > +    qdict = qobject_to(QDict, qobj);
> > +    assert(qdict);
> > +
> > +    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
> > +    if (local_err) {
> > +        goto fail;
> > +    }
> > +
> > +    (void)qdev_device_add(opts, &local_err);
> > +    if (local_err) {
> > +        goto fail;
> > +    }
> > +
> > +fail:
> > +    if (local_err) {
> > +        error_report_err(local_err);
> > +        /* TODO: communicate the exact error message to proxy */
> > +    }
> > +
> > +    notify_proxy(wait, 1);
> > +
> > +    PUT_REMOTE_WAIT(wait);
> > +}
> > +
> >  static void process_msg(GIOCondition cond)
> >  {
> >      ProcMsg *msg = NULL;
> > @@ -189,6 +232,9 @@ static void process_msg(GIOCondition cond)
> >      case SET_IRQFD:
> >          process_set_irqfd_msg(remote_pci_dev, msg);
> >          break;
> > +    case DEVICE_ADD:
> > +        process_device_add_msg(msg);
> > +        break;
> 
> wrong patch?
> 
> >      default:
> >          error_setg(&err, "Unknown command");
> >          goto finalize_loop;
> > @@ -225,6 +271,8 @@ int main(int argc, char *argv[])
> >  
> >      bdrv_init_with_whitelist();
> >  
> > +    qemu_add_opts(&qemu_device_opts);
> > +
> 
> wrong patch?
> >      if (qemu_init_main_loop(&err)) {
> >          error_report_err(err);
> >          return -EBUSY;
> > -- 
> > 1.8.3.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
